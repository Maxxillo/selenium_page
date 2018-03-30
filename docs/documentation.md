# Documentation

documenting using yard gem:

* http://www.rubydoc.info/gems/yard/file/docs/Tags.md

### Useful tags

@raise [Types] description
# @raise [AccountBalanceError] if the account does not have
#   sufficient funds to perform the transaction
def withdraw(amount) end

@return [Types] description
A regular return value
# @return [Fixnum] the size of the file
def size; @file.size end
A method returns an Array or a single object
# @return [String] if a single object was returned
#   from the database.
# @return [Array<String>] if multiple objects were
#   returned.
def find(query) end

@see name description
# Synchronizes system time using NTP.
# @see http://ntp.org/documentation.html NTP Documentation
# @see NTPHelperMethods
class NTPUpdater; end

@!attribute [r | w | rw] attribute_name
   Indented attribute docstring
   Defining a simple readonly attribute
# @!attribute [r] count
#   @return [Fixnum] the size of the list
Defining a simple readwrite attribute
# @!attribute name
#   @return [String] the name of the user

@!method method_signature(parameters)
   Indented method docstring
   Defining a simple method
# @!method quit(username, message = "Quit")
#   Sends a quit message to the server for a +username+.
#   @param [String] username the username to quit
#   @param [String] message the quit message
quit_message_method
Attaching multiple methods to the same source
# @!method method1
# @!method method2
create_methods :method1, :method2
