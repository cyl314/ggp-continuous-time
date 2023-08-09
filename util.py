import time

# Timer
class Timer:
    def __init__(self):
        self.start = time.time()

    def freeze(self):
        self.freeze_start = time.time()

    def unfreeze(self):
        self.freeze_end = time.time()
        # Update start time
        self.start = self.start + self.freeze_end - self.freeze_start
    
    def split(self):
        return time.time() - self.start