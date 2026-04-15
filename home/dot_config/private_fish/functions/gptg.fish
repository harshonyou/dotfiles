# Proofread and grammar-check text using tgpt
# Output saved to /tmp/markdown_buffer.md (view with: glow /tmp/markdown_buffer.md or alias gpto)
# Usage: gptg "Your text here"
function gptg --description "Grammar check and proofread text via tgpt"
    if test (count $argv) -gt 0
        tgpt "Act as a proofreader and review the following text. Feel free to rephrase sentences or make changes to enhance clarity but maintain the overall tone and style of the original. You're allowed to make slight refinement for clarity and tone if needed. Make sure the sentences sounds natural, flows well and comes out polite. Show all changes in bold so I can see what has been updated. \n\n Here's the text: \"$argv\"" | tee /tmp/markdown_buffer.md
    else
        echo "No arguments provided!"
    end
end
