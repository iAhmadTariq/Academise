from flask import Flask, request, jsonify
from flask_cors import CORS
import openai
import time

app = Flask(__name__)

CORS(app, resources={r"/": {"origins":"*"}})

# Set your OpenAI API key
openai.api_key = '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'

@app.route('/', methods=['POST'])
def get_response():
    try:
        # Get the prompt from the Flutter app
        prompt = request.json['prompt']

        # Call the ChatGPT model to generate a response
        response = generate_chatgpt_response(prompt)

        # Return the response to the Flutter app
        return jsonify({'response': response})

    except Exception as e:
        return jsonify({'error': str(e)}), 500

def generate_chatgpt_response(prompt):
    # Customize the prompt if needed
    messages = [
        {
            "role": "system", 
            "content": "You are an intelligent teacher who gives answer in precise and simple words that a 5th grade can understand."
        }
    ]

    while True:
        if prompt.lower() == "exit":
            print("Goodbye!")
            return "Goodbye!"

        if prompt:
            messages.append({"role": "user", "content": prompt})
            try:
                chat = openai.ChatCompletion.create(
                    model="gpt-3.5-turbo", messages=messages
                )
                reply = chat.choices[0].message.content
            except openai.error.OpenAIError as e:
                print(f"Error: {e}")
                return f"Error: {e}"
            except openai.error.RateLimitError as e:
                print(f"Error: {e}")
                # Wait for a specific amount of time before retrying
                time.sleep(5)  # Wait for 5 seconds
                continue
            except Exception as e:
                print(f"Unexpected error: {e}")
                # Handle other unexpected errors if needed
                return f"Unexpected error: {e}"

            # Return the generated response
            return reply

if __name__ == '__main__':
    app.run(debug=True,host='0.0.0.0', port=5000)
