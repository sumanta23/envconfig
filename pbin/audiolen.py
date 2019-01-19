import sys
import wave
import contextlib




def main():
    # print command line arguments
    fname = sys.argv[1:][0]
    duration = 0
    with contextlib.closing(wave.open(fname,'r')) as f:
        frames = f.getnframes()
        rate = f.getframerate()
        duration = frames / float(rate)

    print(duration)

if __name__ == "__main__":
    main()
