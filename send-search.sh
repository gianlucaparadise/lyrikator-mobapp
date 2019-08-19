# usage: sh send-search.sh text

# The App needs to be published into the Play Store to let Google Assistant open the app
inputQuery=$(printf %q "$1")
adb shell am start -a com.google.android.gms.actions.SEARCH_ACTION -e query "$inputQuery" com.example.lyrikator