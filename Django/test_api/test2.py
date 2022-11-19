import re

print(bool(re.search(pattern="\s",string="sdfsdf")))


print(bool(re.search(pattern="[^a-zA-Z0-9]",string="mm_mm")))

print(re.search(pattern="[^a-zA-Z0-9]",string="mm_mm"))
