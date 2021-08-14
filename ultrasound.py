import pyaudio, time
import numpy

p = pyaudio.PyAudio()

volume = 0.5     # range [0.0, 1.0]
fs = 44100       # sampling rate, Hz, must be integer
duration = 1   # in seconds, may be float
f = 24000.0        # sine frequency, Hz, may be float

# generate samples, note conversion to float32 array
samples = (numpy.sin(2*numpy.pi*numpy.arange(fs*duration)*f/fs)).astype(numpy.float32)

# for paFloat32 sample values must be in range [-1.0, 1.0]
stream = p.open(format=pyaudio.paFloat32,
                channels=1,
                rate=fs,
                output=True)

# play. May repeat with different volume values (if done interactively)
while True:
    stream.write(volume*samples)
    time.sleep(0.5)
stream.stop_stream()
stream.close()

p.terminate()
