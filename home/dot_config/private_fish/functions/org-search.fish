# Search org-agenda files via org-ql and print matching headings
# Requires a running Emacs server with org-ql installed
# Usage: org-search "keyword"
function org-search --description "Search org-mode agenda files via org-ql"
    set -l output (/usr/bin/emacsclient -a "" -e "(message \"%s\" (mapconcat #'substring-no-properties \
        (mapcar #'org-link-display-format \
        (org-ql-query \
        :select #'org-get-heading \
        :from  (org-agenda-files) \
        :where (org-ql--query-string-to-sexp \"$argv\"))) \
        \"
    \"))")
    printf $output
end
