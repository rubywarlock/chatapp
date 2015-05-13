# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
	lastId = 0
	chat_window = $('.chat-room')

	scrollDown = ->
		chat_height = chat_window.scrollHeight
		chat_window.scrollTop(chat_height)

	scrollDown()

	$('[type=submit]').click (e) ->
		#nick = $('[name=message[nick]]')
		message = $('[name=[message]]')
		e.preventDefault()

		$.ajax
			url: 'http://localhost:3000/chat/incoming'
			method: 'POST'
			data:
				nick: nick.val()
				message: message.val()
			dataType: 'json'

		message.value("")

	setInterval ->
		$.ajax
			url: 'http://localhost:3000/chat/output'
			method: 'GET'
			dataType: 'json'
			data:
				last_id: lastId
			success: (data, status, xhr) ->
				for messageObject in data
					messageRow = $("<div class='message'></div>")
					timestamp = $("<span class='timestamp'></span>")
					timestamp.text(messageObject.time + ": ")

					nick = $("<span class='nick'></span>")
					nick.text(messageObject.nick)

					message = $("<span class='message-text'></span>")
					message.text(messageObject.message)

					messageRow.append(nick)
					messageRow.append(timestamp)
					messageRow.append(message)

					$(".chat-room").append(messageRow)
					scrollDown()
					lastId = messageObject.id if messageObject.id > lastId
	, 4000
