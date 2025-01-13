document.addEventListener('DOMContentLoaded', function() {
    var chatbotBar = document.getElementById('chatbot-bar');
    var openButton = document.getElementById('open-chatbot');
    var closeButton = document.getElementById('close-chatbot');
    var messageInput = document.getElementById('messageinput');

    openButton.addEventListener('click', function() {
        chatbotBar.style.display = 'block';
        openButton.style.display = 'none';
    });

    closeButton.addEventListener('click', function() {
        chatbotBar.style.display = 'none';
        openButton.style.display = 'block';
    });

    messageInput.addEventListener('keypress', function(event) {
        if (event.key === 'Enter') {
            sendMessage();
        }
    });
});

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

