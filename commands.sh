#!/bin/bash
# Edit your commands in this file.

# This file is public domain in the USA and all free countries.
# Elsewhere, consider it to be WTFPLv2. (wtfpl.net/txt/copying)

if [ "$1" = "source" ];then
	# Edit the token in here
	source token
	# Set INLINE to 1 in order to receive inline queries.
	# To enable this option in your bot, send the /setinline command to @BotFather.
	INLINE=0
	# Set to .* to allow sending files from all locations
	FILE_REGEX='.*'
else
	if ! tmux ls | grep -v send | grep -q $copname; then
			send_message "${USER[ID]}" "${URLS[*]}"
		[ ! -z ${URLS[*]} ] && {
			curl -s ${URLS[*]} -o $NAME -L
			send_file "${USER[ID]}" $(echo "$NAME" | sed 's/\s*//g' | tr -d '\n')
			send_message "${USER[ID]}" "Sending URL ($(echo "${URLS[*]}" | sed 's/\s*//g' | tr -d '\n')) result is $res"
			rm "$NAME"
		}
		[ ! -z ${LOCATION[*]} ] && send_location "${USER[ID]}" "${LOCATION[LATITUDE]}" "${LOCATION[LONGITUDE]}"

		# Inline
		if [ $INLINE == 1 ]; then
			# inline query data
			iUSER[FIRST_NAME]=$(echo "$res" | sed 's/^.*\(first_name.*\)/\1/g' | cut -d '"' -f3 | tail -1)
			iUSER[LAST_NAME]=$(echo "$res" | sed 's/^.*\(last_name.*\)/\1/g' | cut -d '"' -f3)
			iUSER[USERNAME]=$(echo "$res" | sed 's/^.*\(username.*\)/\1/g' | cut -d '"' -f3 | tail -1)
			iQUERY_ID=$(echo "$res" | sed 's/^.*\(inline_query.*\)/\1/g' | cut -d '"' -f5 | tail -1)
			iQUERY_MSG=$(echo "$res" | sed 's/^.*\(inline_query.*\)/\1/g' | cut -d '"' -f5 | tail -6 | head -1)

			# Inline examples
			if [[ $iQUERY_MSG == photo ]]; then
				answer_inline_query "$iQUERY_ID" "photo" "http://blog.techhysahil.com/wp-content/uploads/2016/01/Bash_Scripting.jpeg" "http://blog.techhysahil.com/wp-content/uploads/2016/01/Bash_Scripting.jpeg"
			fi

			if [[ $iQUERY_MSG == sticker ]]; then
				answer_inline_query "$iQUERY_ID" "cached_sticker" "BQADBAAD_QEAAiSFLwABWSYyiuj-g4AC"
			fi

			if [[ $iQUERY_MSG == gif ]]; then
				answer_inline_query "$iQUERY_ID" "cached_gif" "BQADBAADIwYAAmwsDAABlIia56QGP0YC"
			fi
			if [[ $iQUERY_MSG == web ]]; then
				answer_inline_query "$iQUERY_ID" "article" "Telegram" "https://telegram.org/"
			fi
		fi
	fi
	case $MESSAGE in
		'/question')
			startproc "./question"
			;;
		'/info')
			send_message "${USER[ID]}" "This is bashbot, the Telegram bot written entirely in bash."
			;;
		'/start')
			send_message "${USER[ID]}" "This the official bot of the @pwrtelegram api.
I am basically a testing platform for the @pwrtelegram API.

I am connected to the beta PWRTelegram API (beta.pwrtelegram.xyz), so sometimes I might spit out some weird errors or not work at all. That means @danogentili is busy debugging the API :)

Try sending me files or the following commands, if you encounter some bugs send @danogentili a screenshot!

Available commands:
• /start: Start bot and get this message.
• /info: Get shorter info message about this bot.
• /question: Start interactive chat.
• /cancel: Cancel any currently running interactive chats.
Written by Drew (@topkecleon) and Daniil Gentili (@danogentili).
http://github.com/pwrtelegram/pwrtelegram-bot
"
			;;
		'/cancel')
			if tmux ls | grep -q $copname; then killproc && send_message "${USER[ID]}" "Command canceled.";else send_message "${USER[ID]}" "No command is currently running.";fi
			;;
		*)
			if tmux ls | grep -v send | grep -q $copname;then inproc; else send_message "${USER[ID]}" "$MESSAGE" "safe";fi
			;;
	esac
fi
