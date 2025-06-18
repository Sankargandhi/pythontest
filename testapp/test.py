from flask import Flask
app = Flask(__name__)
 
@app.route('/')
def home():
    return "CI-CD Implementation : 17:08 18-06-2025"
 
if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')