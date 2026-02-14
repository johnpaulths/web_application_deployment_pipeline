from flask import Flask, render_template
import os
import socket

app = Flask(__name__)

@app.route('/')
def home():
    environment = os.getenv('ENVIRONMENT', 'unknown')
    version = os.getenv('APP_VERSION', 'unknown')
    hostname = socket.gethostname()
    
    return render_template('index.html', 
                         environment=environment,
                         version=version,
                         hostname=hostname)

@app.route('/health')
def health():
    return {'status': 'healthy', 'environment': os.getenv('ENVIRONMENT', 'unknown')}, 200

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
```

**Create `app/requirements.txt`:**
```
Flask==3.0.0
gunicorn==21.2.0
