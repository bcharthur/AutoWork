from flask import Flask
from Controller.itemController import item_bp

app = Flask(__name__)
app.register_blueprint(item_bp, url_prefix="/item")

if __name__ == '__main__':
    app.run(debug=True)

