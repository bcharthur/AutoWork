from flask import Flask
from Controller.{name}Controller import {name}_bp

app = Flask(__name__)
app.register_blueprint({name}_bp, url_prefix="/{name}")

if __name__ == '__main__':
    app.run(debug=True)
