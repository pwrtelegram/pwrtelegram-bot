#!/bin/bash
# Edit your commands in this file.

# This file is public domain in the USA and all free countries.
# Elsewhere, consider it to be WTFPLv2. (wtfpl.net/txt/copying)

if [ "$1" = "source" ];then
	# Edit the token in here
	source token
	# Set INLINE to 1 in order to receive inline queries.
	# To enable this option in your bot, send the /setinline command to @BotFather.
	INLINE=1
	# Set to .* to allow sending files from all locations
	FILE_REGEX='.*'
else

	if ! tmux ls | grep -v send | grep -q $copname; then
		[ ! -z ${URLS[*]} ] && {
			send_message "${USER[ID]}" "${URLS[*]}"


#			curl -s ${URLS[*]} -o $NAME -L
#			send_file "${USER[ID]}" $(echo "$NAME" | sed 's/\s*//g' | tr -d '\n')
			send_file "${USER[ID]}" $(echo "${URLS[*]}" | sed 's/\s*//g' | tr -d '\n')
			send_message "${USER[ID]}" "Sending URL ($(echo "${URLS[*]}" | sed 's/\s*//g' | tr -d '\n')) result is $res"
			rm "$NAME"
		}
		[ ! -z ${LOCATION[*]} ] && send_location "${USER[ID]}" "${LOCATION[LATITUDE]}" "${LOCATION[LONGITUDE]}"

		# Inline
                        # inline query data
                        iUSER[FIRST_NAME]=$(echo "$res" | sed 's/^.*\(first_name.*\)/\1/g' | cut -d '"' -f3 | tail -1)
                        iUSER[LAST_NAME]=$(echo "$res" | sed 's/^.*\(last_name.*\)/\1/g' | cut -d '"' -f3)
                        iUSER[USERNAME]=$(echo "$res" | sed 's/^.*\(username.*\)/\1/g' | cut -d '"' -f3 | tail -1)
                        iQUERY_ID=$(echo "$res" | sed 's/^.*\(inline_query.*\)/\1/g' | cut -d '"' -f5 | tail -1)
                        iQUERY_MSG=$(echo "$res" | sed 's/^.*\(inline_query.*\)/\1/g' | cut -d '"' -f5 | tail -6 | head -1)
		re='^[0-9]+$'
		if  [[ $iQUERY_ID =~ $re ]]; then
			# Inline examples
			if [[ $iQUERY_MSG == photo ]]; then
				answer_inline_query "$iQUERY_ID" "photo" "http://blog.techhysahil.com/wp-content/uploads/2016/01/Bash_Scripting.jpeg" "http://blog.techhysahil.com/wp-content/uploads/2016/01/Bash_Scripting.jpeg"
return
			fi

			if [[ $iQUERY_MSG == gif ]]; then
				answer_inline_query "$iQUERY_ID" "gif" "http://i.giphy.com/149t2dI5M5nzvq.gif" "http://blog.techhysahil.com/wp-content/uploads/2016/01/Bash_Scripting.jpeg" "http://blog.techhysahil.com/wp-content/uploads/2016/01/Bash_Scripting.jpeg"
return
			fi
			if [[ $iQUERY_MSG == cgif ]]; then
				answer_inline_query "$iQUERY_ID" "cached_gif" "BQADBAADpAADf3ErDHpXzEivjoV_Ag"
return
			fi
			if [[ $iQUERY_MSG == cmgif ]]; then
				answer_inline_query "$iQUERY_ID" "cached_mpeg4_gif" "BQADBAADpAADf3ErDHpXzEivjoV_Ag"
return
			fi

			if [[ $iQUERY_MSG == zip ]]; then
				answer_inline_query "$iQUERY_ID" "document" "1GB zip file" "1GB zip file" "https://storage.pwrtelegram.xyz/pwrtelegrambot/document/download_604040884794687598.zip"
#"BQADBAADbgAD_PthCPK954yXfJEDAg"
return
			fi
			if [[ $iQUERY_MSG == winx ]]; then
#				answer_inline_query "$iQUERY_ID" "document" "yay" "yay" ""
#"BQADBAADbgAD_PthCPK954yXfJEDAg"
return
			fi
			if [[ $iQUERY_MSG == web ]]; then
				answer_inline_query "$iQUERY_ID" "article" "Telegram" "https://telegram.org/"
return
			fi
                        if [ ! -z "$iQUERY_ID" ]; then
                                answer_inline_query "$iQUERY_ID" "article" "Info message" "This the official bot of the @pwrtelegram api.
I am basically a testing platform for the @pwrtelegram API.

I am connected to the beta PWRTelegram API (beta.pwrtelegram.xyz), so sometimes I might spit out some weird errors or not work at all. That means @danogentili is busy debugging the API :)

Try sending me files or the following commands, if you encounter some bugs send @danogentili a screenshot!

Available inline queries:
zip - Send 1gb zip file
gif - Send funny gif
cgif - Send funny cached gif
cmgif - Send funny cached mpeg4 gif
photo - Send photo

Written by Drew (@topkecleon) and Daniil Gentili (@danogentili).
http://github.com/pwrtelegram/pwrtelegram-bot"
                                return
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
• /dl: Download file using file/id URL.
Written by Drew (@topkecleon) and Daniil Gentili (@danogentili).
http://github.com/pwrtelegram/pwrtelegram-bot
"
			;;
		'/cancel')
			if tmux ls | grep -q $copname; then killproc && send_message "${USER[ID]}" "Command canceled.";else send_message "${USER[ID]}" "No command is currently running.";fi
			;;
		'/dl'*)
			send_file "${USER[ID]}" $(echo "${MESSAGE}" | sed 's/^\/dl //g' | tr -d '\n')
			oldres="$res"
			send_message "${USER[ID]}" "Result is $res, reforward the file to me to get the URL download link."

			;;
		*)
			if tmux ls | grep -v send | grep -q $copname;then inproc; else send_message "${USER[ID]}" "$MESSAGE" "safe";fi
			;;
	esac
fi
