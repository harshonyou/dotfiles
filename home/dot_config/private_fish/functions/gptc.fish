# Generate Conventional Commit messages for given change description using tgpt
# Usage: gptc "added user auth with JWT"
function gptc --description "Generate git commit messages via tgpt"
    if test (count $argv) -gt 0
        tgpt "You are an assistant that generates helpful and concise git commit messages adhering to Conventional Commits. Generate a Git commit message for the following changes, following the Git commit standards. Make sure you provide a few alternatives. \n\n Here's the text: \"$argv\""
    else
        echo "No arguments provided!"
    end
end
