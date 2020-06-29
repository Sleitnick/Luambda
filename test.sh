git filter-branch --env-filter '
if [ "$GIT_AUTHOR_NAME" = "scleitnick" ]; then \
	export GIT_AUTHOR_NAME="Sleitnick" GIT_AUTHOR_EMAIL="sleitnick@gmail.com"; \
fi
'