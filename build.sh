echo "<html>"
echo "<head>"
echo "<meta http-equiv=\"content-type\" content=\"text/html; charset=utf-8\" />"
echo "<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.5\">"
echo "<link href=\"./main.css\" rel=\"stylesheet\" type=\"text/css\">"
echo "<link rel=\"alternate\" type=\"application/atom+xml\" href=\"/atom.xml\" title=\"Atom feed\">"
echo "<link rel=\"shortcut icon\" href=\"http://www.yinwang.org/images/Yc.jpg\">"
echo "<title>"$2"</title>"
echo "</head>"
echo "<body>"
echo "<script>"
echo "if (/mobile/i.test(navigator.userAgent) || /android/i.test(navigator.userAgent))"
echo "{"
echo "   document.body.classList.add('mobile');"
echo "}"
echo "</script>"
echo "<div class=\"inner\">"
pandoc --from=markdown --to=html $1
echo "</div>"
echo "</body>"
echo "</html>"