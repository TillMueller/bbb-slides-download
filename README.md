# Simple download script for BBB slides
This script can be used to download a slide set from BigBlueButton

## Dependencies
- curl (to download the slides)
- librsvg2-bin (to convert the svgs to pdfs)
- pdfunite (to merge the pdfs into one)

## Usage
Run the script with the base link for the slides as an argument.
The link can be retrieved by "inspecting" the current slide.

It should look somewhat like this: `https://[BBB-Instance]/bigbluebutton/presentation/9405d6b79322aa96ddcaa2883f54f54ffb5140b5-1612443184585/9405d6b79322aa96ddcaa2883f54f54ea2a140b5-89124431845ef/893b709d78182d3194e1d070e48927d6c68067fc-71f2443237937/svg/22`

Then just run the script:
`./download-slides.sh link`

By default the scripts generates a random string of characters to use as a
prefix for the file names.
If you want to specify a prefix you can do this with the second argument:
`./download_slides.sh link [slide deck name]`

# Note
By default the script is limited to downloading 1024 slides in one batch to
limit the possible damage if something goes wrong.
Should you want to lift this limit just change the respective variable in the
script.
