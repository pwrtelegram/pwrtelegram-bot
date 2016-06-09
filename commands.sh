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
			send_message "${CHAT[ID]}" "${URLS[*]}"


#			curl -s ${URLS[*]} -o $NAME -L
#			send_file "${CHAT[ID]}" $(echo "$NAME" | sed 's/\s*//g' | tr -d '\n')
			send_file "${CHAT[ID]}" $(echo "${URLS[*]}" | sed 's/\s*//g' | tr -d '\n')
			send_message "${CHAT[ID]}" "Sending URL ($(echo "${URLS[*]}" | sed 's/\s*//g' | tr -d '\n')) result is $res"
			rm "$NAME"
		}
		[ ! -z ${LOCATION[*]} ] && send_location "${CHAT[ID]}" "${LOCATION[LATITUDE]}" "${LOCATION[LONGITUDE]}"

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
			if [[ $iQUERY_MSG == bot ]]; then
				InlineQueryResult='[{"type":"file","id":"'$RANDOM'","title":"This bot","caption":"This bot","document_url":"","mime_type":""}]'
				res=$(curl -s "$INLINE_QUERY" -F "inline_query_id=$iQUERY_ID" -F "results=$InlineQueryResult" -F "inline_file0=@bashbot.sh")
#"BQADBAADbgAD_PthCPK954yXfJEDAg"
				return
			fi
			if [[ $iQUERY_MSG == 10 ]]; then
				answer_inline_query "$iQUERY_ID" "document" "yay" "yay" "http://speedtest.ftp.otenet.gr/files/test10Mb.db"
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

The @pwrtelegram bot API is an enhanced version of telegram's bot API that has all of the official telegram bot API features plus:  
* Downloading of files up to 1.5 GB in size  
* Anonymous file storage (the URL of downloaded files does not contain your bot's token)
* Uploading of files up to 1.5 GB in size  
* Uploading of files using an URL
* Reuploading of files using a file ID and different file type or file name.
* Uploading of any file/URL/file ID with automagical type recognition.  
* Uploading of any file/URL/file ID without sending the file to a specific user.  
* Automagical metadata recognition of sent files/URLs/file IDs.  
* Deleting of text messages sent from the bot  
* Uploading of files bigger than 5 megabytes with inline queries (supports both URLs and direct uploads)
* Automatical type recognition for files sent using answerinlinequery 
* Both webhooks and getupdates are supported.
* webhook requests can be recieved even on insecure http servers.
* It is open source(https://github.com/pwrtelegram)!
* It can be installed on your own server(https://github.com/pwrtelegram/pwrtelegram-backend)!


I am connected to the beta PWRTelegram API (beta.pwrtelegram.xyz), so sometimes I might spit out some weird errors or not work at all. That means @danogentili is busy debugging the API :)

Try sending me one of the following inline queries, if you encounter some bugs send @danogentili a screenshot!

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
			send_message "${CHAT[ID]}" "This is bashbot, the Telegram bot written entirely in bash."
			;;
		'/start')
			send_message "${CHAT[ID]}" "This the official bot of the @pwrtelegram api.
I am basically a testing platform for the @pwrtelegram API.

Thw @pwrtelegram bot API is an enhanced version of telegram's bot API that has all of the official telegram bot API features plus:  
* Downloading of files up to 1.5 GB in size  
* Anonymous file storage (the URL of downloaded files does not contain your bot's token)
* Uploading of files up to 1.5 GB in size  
* Uploading of files using an URL
* Reuploading of files using a file ID and different file type or file name.
* Uploading of any file/URL/file ID with automagical type recognition.  
* Uploading of any file/URL/file ID without sending the file to a specific user.  
* Automagical metadata recognition of sent files/URLs/file IDs.  
* Deleting of text messages sent from the bot  
* Uploading of files bigger than 5 megabytes with inline queries (supports both URLs and direct uploads)
* Automatical type recognition for files sent using answerinlinequery 
* Both webhooks and getupdates are supported.
* webhook requests can be recieved even on insecure http servers.
* It is open source (https://github.com/pwrtelegram)!
* It can be installed on your own server (https://github.com/pwrtelegram/pwrtelegram-backend)!


I am connected to the beta PWRTelegram API (beta.pwrtelegram.xyz), so sometimes I might spit out some weird errors or not work at all. That means @danogentili is busy debugging the API :)


If you send me a file, even a 1.5 gb one, I will download it, return the download URL along with some json and resend it to you.

Available commands:
• /start: Start bot and get this message.
• /info: Get shorter info message about this bot.
• /dl: Download file using file id/ URL (up to 1.5 gb).

Written by Daniil Gentili (@danogentili).
http://github.com/pwrtelegram/pwrtelegram-bot
If you encounter bugs send @danogentili a screenshot!
"
			;;
		'/cancel')
			if tmux ls | grep -q $copname; then killproc && send_message "${CHAT[ID]}" "Command canceled.";else send_message "${CHAT[ID]}" "No command is currently running.";fi
			;;
		'/dl')
			send_message "${CHAT[ID]}" "Usage: /dl url filename";;
		'/dl'*)
			echo "$MESSAGE" | grep -q "mkv" && { send_message "${CHAT[ID]}" "This bot can't download mkv files."; return; };
			send_message "${CHAT[ID]}" "The download was started. "

			res=$(curl -s "$FILE_DL_URL" -F "chat_id=${CHAT[ID]}" -F "file=$(echo "$MESSAGE" | sed 's/^\/dl //g;s/\s.*//g')" -F "name=$(echo "$MESSAGE" | sed 's/^\/dl //g;s/[^ ]*\s//')")

#			send_file "${CHAT[ID]}" $(echo "${MESSAGE}" | sed 's/^\/dl //g' | tr -d '\n')
#			oldres="$res"
			send_message "${CHAT[ID]}" "Result is $res, reforward the file to me to get the URL download link. "

			;;
		*)
			if tmux ls | grep -v send | grep -q $copname;then inproc; else send_message "${CHAT[ID]}" "$MESSAGE" "safe";fi
			;;
	esac
fi
