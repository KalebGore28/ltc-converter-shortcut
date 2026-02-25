# LTC Timecode Converter

A macOS bash script that extracts Linear Timecode (LTC) from video files and embeds it as metadata. Designed for seamless integration with Apple Shortcuts for quick batch processing of video files.

## Overview

This tool automatically detects LTC timecode embedded in a video file's audio track and applies it as metadata to create a new file with proper timecode information. This is particularly useful for professional video workflows where timecode synchronization is essential.

**What is LTC?** Linear Timecode (LTC) is an audio signal that encodes SMPTE timecode data. It's commonly recorded on audio tracks during video production to synchronize multiple cameras and audio recorders.

## Features

- Extracts LTC timecode from video file audio tracks
- Automatically detects timecode from the first 5 seconds of audio
- Creates new files with embedded timecode metadata
- Removes audio tracks from output (preserves video only)
- Batch processing support for multiple files
- Easy integration with Apple Shortcuts for drag-and-drop functionality

## Prerequisites

- **macOS** (required for Apple Shortcuts integration)
- **Homebrew** package manager
- **ffmpeg** - for video processing
- **ltc-tools** - for LTC detection (includes `ltcdump`)

## Installation

Install the required dependencies using Homebrew:

```bash
brew install ffmpeg ltc-tools
```

## Usage

### Standalone Command Line Usage

Copy the script from this repository and save it locally. Then run it directly from the terminal:

```bash
./script.sh video1.mov video2.mp4 video3.mov
```

The script will process each file and create output files with the suffix `_tc` (e.g., `video1_tc.mov`).

### Apple Shortcuts Integration

Follow these steps to create an Apple Shortcut for easy drag-and-drop conversion:

#### Setup Instructions

1. **Create a new Shortcut**
   - Open the Shortcuts app on macOS
   - Click the `+` button to create a new shortcut

2. **Add Shell Script action**
   - Search for and add the "Run Shell Script" action
   - Copy the contents of `script.sh` and paste it into the text area
   - Under "Input", select **Shortcut Input**
   - Change "Pass Input" from "to stdin" to **as arguments**
   - Leave "Run as administrator" unchecked

3. **Configure input handling**
   - A "Receive" action will appear above the shell script
   - Under "If there is no input:", select **Ask for**
   - In the type dropdown, choose **Files**

4. **Optional: Add output display**
   - Add a "Show Result" action below the shell script to see the output

5. **Enable script execution**
   - Open Shortcuts preferences (Shortcuts → Settings)
   - Go to the Advanced tab
   - Enable **Allow Running Scripts**

6. **Save and use**
   - Name your shortcut (e.g., "Convert LTC Timecode")
   - The shortcut is now ready to use
   - You can add it to your Dock for quick access

#### Running the Shortcut

- Run the shortcut and select video files when prompted
- Or right-click video files in Finder → Share → Your Shortcut Name
- Or drag and drop files onto the shortcut in your Dock

## How It Works

1. Extracts the first 5 seconds of audio from the video file
2. Uses `ltcdump` to detect LTC timecode in the audio
3. Creates a new video file with:
   - Original video track (copied, not re-encoded)
   - Audio tracks removed
   - Detected timecode embedded as metadata

## Output

- Input: `video.mov`
- Output: `video_tc.mov`

The output file contains the video stream with embedded timecode metadata but no audio tracks.

## Troubleshooting

**No LTC found**
- Ensure your video has LTC timecode on an audio track
- Verify the LTC signal is present in the first 5 seconds
- Check that the audio is on the first audio track (index 0)

**Shortcut doesn't run**
- Verify "Allow Running Scripts" is enabled in Shortcuts settings
- Check that ffmpeg and ltc-tools are installed: `which ffmpeg ltcdump`
- Ensure the paths in the script match your Homebrew installation (default: `/opt/homebrew/bin/`)

**Permission errors**
- Grant Shortcuts access to files in System Settings → Privacy & Security → Automation

## License

This project is provided as-is for professional video production workflows.

## Contributing

Contributions, issues, and feature requests are welcome.
