from flask import Flask, render_template, request, jsonify
import json
import os
from dotenv import load_dotenv

app = Flask(__name__)

# Load environment variables from .env file
load_dotenv()

# Load the JSON data
with open('cv_jonas.json') as json_file:
    cv_data = json.load(json_file)

@app.route('/')
def home():
    return render_template('start.html')

@app.route('/send', methods=['POST'])
def send():
    data = request.get_json()
    user_message = data['message']

    # Generate a response using the JSON data
    bot_reply = get_response_from_cv_data(user_message, cv_data)

    return jsonify({'reply': bot_reply})

def get_response_from_cv_data(user_message, cv_data):
    # Normalize the user message for comparison
    user_message = user_message.lower().strip()

    # Search for the question in the cv_data
    for entry in cv_data:
        if entry['Qestion'].lower() == user_message:
            return entry['Answer']

    # If no match is found, return a default response
    return "Sorry, I don't have an answer for that."

if __name__ == '__main__':
    app.run(debug=True)
