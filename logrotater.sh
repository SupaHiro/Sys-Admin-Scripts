#!/bin/bash -x
#Author: Nicole Green
#17-11-2012


# Grab the command line arguments and put them into variables with meaningful names
log_path="$1"
log_name="$2"
retention="$3"

# Check that the log path argument given is actually a valid directory
if [[ -d "$log_path" ]]
then
	# Yes? cd into that directory
	cd "$log_path"
else
	# No? Exit with an error
	echo $log_path is not valid
	exit 1
fi

# Use the find command to enumerate all the files in the current directory which match the name given
# Then use sort -nr to reverse the output so that we deal with the oldest (highest numbered) file first
# Pipe this output into a while loop
find . -maxdepth 1 -name $log_name\* -regex '.*\.[0-9]+$' -printf %f\\n | sort -nr | while read logfile
do
	echo $logfile

	# Extract the number at the end of the filename
	number=$(echo $logfile | sed 's/.*\.\([0-9]\+\)$/\1/')

	# Increment this number
	number=$(($number + 1))

	# If rotating this file would push the file over the retention limit, just delete it
	if (( $number > $retention ))
	then
		echo rm $logfile
	# Otherwise, rename the file
	else
		mv $logfile $log_name.$number
	fi
done

# Finally, deal with the "current" or "today's" log (no number at the end of the filename)

mv $log_name $log_name.1
