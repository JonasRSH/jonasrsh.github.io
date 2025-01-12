document.addEventListener('DOMContentLoaded', function() {
    var chatContainer = document.getElementById('chat-container');
    chatContainer.style.display = 'none';
    var toggleButton = document.querySelector('.toggle-chat');
    toggleButton.innerHTML = '<img class="chatbotpng" src="chatbot.png" alt="Chatbot">';
});

function toggleChat() {
    var chatContainer = document.getElementById('chat-container');
    var toggleButton = document.querySelector('.toggle-chat');
    if (chatContainer.style.display === 'none' || chatContainer.style.display === '') {
        chatContainer.style.display = 'block';
        toggleButton.innerHTML = '<img class="chatbotpng" src="chatbot.png" alt="Chatbot">';
    } else {
        chatContainer.style.display = 'none';
        toggleButton.innerHTML = '<img class="chatbotpng" src="chatbot.png" alt="Chatbot">';
    }
}

function handleKeyPress(event) {
    if (event.key === 'Enter') {
        sendMessage();
    }
}

function sendMessage() {
    var messageInput = document.getElementById('messageinput');
    var message = messageInput.value;
    if (message.trim() === '') return;

    var chatbox = document.getElementById('chatbox');
    chatbox.innerHTML += '<div class="user-message">' + message + '</div>';
    messageInput.value = '';

    fetch('/send', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({ message: message })
    })
    .then(response => response.json())
    .then(data => {
        chatbox.innerHTML += '<div class="bot-message">' + data.reply + '</div>';
        chatbox.scrollTop = chatbox.scrollHeight;
    })
    .catch(error => {
        console.error('Error:', error);
    });
}

