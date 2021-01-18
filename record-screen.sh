timestamp=$(date -u +"%Y-%m-%d_%H:%M:%S")

echo "output-$timestamp.mp4" | xclip

ffmpeg \
       -f pulse -i alsa_output.pci-0000_00_1f.3.analog-stereo.monitor \
			 -f pulse -i bluez_sink.24_5A_B5_BF_63_70.a2dp_sink.monitor \
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
