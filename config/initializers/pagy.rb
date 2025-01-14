require "pagy/extras/overflow"
Pagy::DEFAULT[:overflow] = :last_page
Pagy::DEFAULT[:limit] = 10 # items per page
Pagy::DEFAULT[:size]  = 5  # nav bar links
