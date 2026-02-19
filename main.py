from fastapi import FastAPI
from prometheus_client import Counter, make_asgi_app
import os
import signal

app = FastAPI()

CRASH_COUNTER = Counter('api_crash_total', 'total number of times crash was triggered')

@app.get("/")
def read_root():
    return {"Status": "Active"}

@app.get("/health")
def health_check():
    return {"status": "healthy"}

@app.get("/simulate-crash")
def crash():
    CRASH_COUNTER.inc() #incrementing the crash counter (before app dies)
    # here I am simulating an error
    os.kill(os.getpid(), signal.SIGTERM) #gets process id of current running python program, terminates that process
    return {"message": "crashing"}

# adding metrics endpoint so Promethus can read the data
metrics_app = make_asgi_app()
app.mount("/metrics", metrics_app)