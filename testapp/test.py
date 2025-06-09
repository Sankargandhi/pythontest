from flask import Flask
app = Flask(__name__)
 
@app.route('/')
def home():
    return "Hello, World! and Clean run - 09-06-2025 19:53"
 
if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')