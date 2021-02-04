# Simple download script for BBB slides
This script can be used to download a slide set from BigBlueButton

## Usage
Run the script with the base link for the slides as an argument.
The link can be retrieved by "inspecting" the current slide.

It should look somewhat like this: `https://[BBB-Instance]/bigbluebutton/presentation/9405d6b79322aa96ddcaa2883f54f54ffb5140b5-1612443184585/9405d6b79322aa96ddcaa2883f54f54ea2a140b5-89124431845ef/893b709d78182d3194e1d070e48927d6c68067fc-71f2443237937/svg/22`

Then just run the script:
`./download-slides.sh [LINK]`
