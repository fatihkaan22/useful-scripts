timestamp=$(date -u +"%Y-%m-%d_%H:%M:%S")

echo "output-$timestamp.mp4" | xclip

defaultSink=$(pactl list sources | grep -E 'Name.*monitor' | cut -d ' '  -f 2)

ffmpeg \
       -f pulse -i alsa_output.pci-0000_00_1f.3.analog-stereo.monitor \
			 -f pulse -i "$defaultSink" \
			 -filter_complex amix=inputs=2 \
			 -f x11grab \
       -framerate 30  \
       -video_size 1920x1080 \
       -i :0.0+1920,0 \
       -vcodec libx264 -preset veryfast -crf 18 \
			 -pix_fmt yuv420p \
			 "output-$timestamp.mp4"

# ffmpeg -f x11grab \
#        -video_size 1920x1080 \
#        -framerate 30  \
#        -i :0.0+1920,0 \
#        -vcodec h264 \
#        -f pulse -ac 2 -i default  \
#        output.mkv
