# Configuration-INIDeserializer

Like [Configuration](https://github.com/IBM-Swift/Configuration), but don't want to use JSON or PList-flavored XML are good systems to write human-friendly configuration files? I agree. Let's use [INI files](https://en.wikipedia.org/wiki/INI_file) instead.

Unlike JSON, INI files support comments, and have a far lower "noise" level than XML or JSON.

## Example

Let's write an INI file that looks like this.

```ini
; Configuration file for my great Swift app
; Lines that start with the ; character are comments

; Site name
site-name = My Great Site

; Site root URL
site-url = https://example.com/mygreatsite

; Database credentials and configuration
[database]
username = hello
password = world
```

Now in your Swift project, add Configuration-INIDeserializer using SPM. Once done, here's how you can use it in your code.

```swift
import Configuration
import Configuration_INIDeserializer // <= Note the underscore

let config = Configuration()

// Tell Configuration how to read INI files. Don't forget this line!
config.use(INIDeserializer())

// Now you can load an INI file
config.load(file: "/path/to/my-config.conf")

// For top-level values, cast from the top level of the configuration "array"
let siteName = config["site-name"] as? String ?? "Default Site Name"

// For values in sections, try casting the section as a [String: String]
guard let databaseCredentials = config["database"] as? [String: String] else {
    print("Can't find database credentials")
    exit(1)
}
let databaseUsername = databaseCredentials["username"]
```

## Yet Another Swift Project by [Nocturnal](https://nocturnal.solutions)

Feedback, bug reports, and [Patreon tips](https://patreon.com/NocturnalSolutions) accepted with a smile!
