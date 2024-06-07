# ---------------------------------------------------------------------------
# See the NOTICE file distributed with this work for additional
# information regarding copyright ownership.
#
# This is free software; you can redistribute it and/or modify it
# under the terms of the GNU Lesser General Public License as
# published by the Free Software Foundation; either version 2.1 of
# the License, or (at your option) any later version.
#
# This software is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
# Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public
# License along with this software; if not, write to the Free
# Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
# 02110-1301 USA, or see the FSF site: http://www.fsf.org.
# ---------------------------------------------------------------------------

# This is the new XWiki configuration file. In the future it'll replace the old
# xwiki.cfg file. However right now it's only used by some XWiki components.
# As time progresses more and more component will get their configurations from
# this file.
# 
# This file come from one of those locations (in this order):
# * [since 9.3] /etc/xwiki/xwiki.properties
# * /WEB-INF/xwiki.properties in the web application resources

#-------------------------------------------------------------------------------------
# Core
#-------------------------------------------------------------------------------------

#-# [Since 1.8RC2]
#-# Specifies the default syntax to use when creating new documents.
#-# Default value is xwiki/2.1.
# core.defaultDocumentSyntax = xwiki/2.1

#-# [Since 2.4M1]
#-# Indicate if the rendering cache is enabled.
#-# Default value is false.
# core.renderingcache.enabled = true

#-# [Since 2.4M1]
#-# A list of Java regex patterns matching full documents reference.
# core.renderingcache.documents = wiki:Space\.Page
# core.renderingcache.documents = wiki:Space\..*
# core.renderingcache.documents = Space\.PageOnWhateverWiki

#-# [Since 2.4M1]
#-# The time (in seconds) after which data should be removed from the cache when not used.
#-# Default value is 300 (5 min).
# core.renderingcache.duration = 300

#-# [Since 2.4M1]
#-# The size of the rendering cache. Not that it's not the number of cached documents but the number of cached results.
#-# (For a single document several cache entries are created, because each action, language and request query string
#-# produces a unique rendering result)
#-# Default value is 100.
# core.renderingcache.size = 100

#-# [Since 7.2M2]
#-# Define which hierarchy is used between pages (for example inside the breadcrumb).
#-# Possible values are "reference" (default) or "parentchild".
#-# If "parentchild" is used, the hierachy is based on the parent/child relationship, which means that any document
#-# could be defined as the parent of an other document.
#-# If "reference" is used, then the children of a document must be placed inside this document. It's less flexible but
#-# more clear.
# core.hierarchyMode = reference

#-------------------------------------------------------------------------------------
# Environment
#-------------------------------------------------------------------------------------

#-# [Since 3.5M1, replaces the container.persistentDirectory property]
#-# The directory used to store persistent data (data that should persist across server restarts). This is an
#-# important directory containing important data and thus it should never be deleted (it should be backed-up along
#-# with the database).
#-# For example this is where the Extension Manager stores downloaded extensions if the extension.localRepository
#-# property isn't configured.
#-#
#-# You can set:
#-# * an absolute path (recommended)
#-# * a relative path (not recommended at all)but in this case the directory will be relative to where the XWiki server
#-#   is started and thus the user under which XWiki is started will need write permissions for the current directory
#-#
#-# Note if the system property xwiki.data.dir is set then this property is not used.
#-# If neither the system property nor this configuration value here are set then the Servlet container's temporary
#-# directory is used; This is absolutely not recommended since that directory could be wiped out at any time and you
#-# should specify a value.
environment.permanentDirectory=/usr/local/xwiki/data

#-------------------------------------------------------------------------------------
# Rendering
#-------------------------------------------------------------------------------------

#-# [Since 1.8RC2]
#-# Specifies how links labels are displayed when the user doesn't specify the label explicitly.
#-# Valid values:
#-#   %w: wiki name
#-#   %s: full space name (e.g. space1.space2)
#-#       Note: Prior to 7.4.2/8.0M2 this was only displaying the last space name
#-#   %ls: last space name. New in 7.4.2/8.0M2
#-#   %p: page name
#-#   %np: nested page name (i.e. will display the space name for Nested Pages). New in 7.4.2/8.0M2
#-#   %P: page name with spaces between camel case words, i.e. "My Page" if the page name is "MyPage"
#-#   %NP: nested page name with spaces between camel case words, i.e. "My Page" if the page name is "MyPage".
#-#        New in 7.4.2/8.0M2
#-#   %t: page title
#-#
#-# Note that if the page title is empty or not defined then it defaults to %np. This is also the case
#-# if the title cannot be retrieved for the document.
#-#
#-# The default is "%np". Some examples: "%s.%p", "%w:%s.%p".
# rendering.linkLabelFormat = %np

#-# [Since 2.0M3]
#-# Overrides default macro categories (Each macro has default categories already defined, for example
#-# "Navigation" for the Table of Contents Macro).
#-# Note: the categories are case sensitive.
#-#
#-# Ex: To redefine the macro categories for the TOC macro so that it'd be in the "My Category" and "Deprecated" 
#-# categories + redefine the category for the Script Macro to be "My Other Category", you'd use:
# rendering.transformation.macro.categories = toc = My Category\,Deprecated
# rendering.transformation.macro.categories = script = My Other Category

#-# [Since 14.8RC1]
#-# Override the default hidden macro categories.
#-# Note: the categories are case sensitive.
#-#
#-# The default value is:
# rendering.transformation.macro.hiddenCategories = Internal,Deprecated
#-#
#-# For instance, to make the "Development" category hidden by default, in addition to the "Internal" and
#-# "Deprecated" categories, you'd use:
# rendering.transformation.macro.hiddenCategories = Development,Internal,Deprecated

#-# [Since 2.5M2]
#-# Specify whether the image dimensions should be extracted from the image parameters and included in the image URL
#-# or not. When image dimensions are included in the image URL the image can be resized on the server side before being
#-# downloaded, improving thus the page loading speed.
#-#
#-# Default value is true.
# rendering.imageDimensionsIncludedInImageURL = true

#-# [Since 2.5M2]
#-# One way to improve page load speed is to resize images on the server side just before rendering the page. The
#-# rendering module can use the image width provided by the user to scale the image (See
#-# rendering.includeImageDimensionsInImageURL configuration parameter). When the user doesn't specify the image width
#-# the rendering module can limit the width of the image based on this configuration parameter.
#-#
#-# The default value is -1 which means image width is not limited by default. Use a value greater than 0 to limit the
#-# image width (pixels). Note that the aspect ratio is kept even when both the width and the height of the image are
#-# limited.
# rendering.imageWidthLimit = 1024
# rendering.imageWidthLimit = -1

#-# [Since 2.5M2]
#-# See rendering.imageWidthLimit
# rendering.imageHeightLimit = 768
# rendering.imageHeightLimit = -1

#-# [Since 2.5M2]
#-# InterWiki definitions in the format alias = URL
#-# See http://en.wikipedia.org/wiki/Interwiki_links for a definition of an InterWiki link
# Some examples:
# rendering.interWikiDefinitions = wikipedia = http://en.wikipedia.org/wiki/
# rendering.interWikiDefinitions = definition = http://www.yourdictionary.com/

#-# [Since 2.4M1]
#-# Change the Pygments style used in the code macro (see http://pygments.org/docs/styles/)
#-# If not set "default" style is used.
# rendering.macro.code.pygments.style = vs

#-# [Since 15.0RC1]
#-# [Since 14.10.2]
#-# The maximum size (in bytes) of attachment to allow as code macro source.
#-# 
#-# The default is:
# rendering.macro.code.source.attachmentMaximumSize = 1000000

#-------------------------------------------------------------------------------------
# Rendering Transformations
#-------------------------------------------------------------------------------------

#-# [Since 2.6RC1]
#-# Controls what transformations will be executed when rendering content.
#-# A transformation modifies the parsed content. For example the Icon transformation replaces some characters with
#-# icons, a WikiWord transformation will automatically create links when it finds wiki words, etc.
#-# Note that the Macro transformation is a special transformation that replaces macro markers by the result of the
#-# macro execution. If you don't list it, macros won't get executed.
#-# The default value is: macro, icon
# rendering.transformations = macro, icon

#-# [Since 2.6RC1]
#-# Icon Transformation Configuration
#-# Defines mappings between suite of characters and the icon to display when those characters are found.
#-# The format is: rendering.transformation.icon.mappings = <suite of characters> = <icon name>
#-# The following mappings are already predefined and you don't need to redefine them unless you wish to override them
#-# [Since 9.3RC1/8.4.5] To disable a default mapping, define it with an empty value. For example:
#-#   rendering.transformation.icon.mappings = (n) =
#-#
#-# rendering.transformation.icon.mappings = :) = emoticon_smile
#-# rendering.transformation.icon.mappings = :( = emoticon_unhappy
#-# rendering.transformation.icon.mappings = :P = emoticon_tongue
#-# rendering.transformation.icon.mappings = :D = emoticon_grin
#-# rendering.transformation.icon.mappings = ;) = emoticon_wink
#-# rendering.transformation.icon.mappings = (y) = thumb_up
#-# rendering.transformation.icon.mappings = (n) = thumb_down
#-# rendering.transformation.icon.mappings = (i) = information
#-# rendering.transformation.icon.mappings = (/) = accept
#-# rendering.transformation.icon.mappings = (x) = cancel
#-# rendering.transformation.icon.mappings = (!) = error
#-# rendering.transformation.icon.mappings = (+) = add
#-# rendering.transformation.icon.mappings = (-) = delete
#-# rendering.transformation.icon.mappings = (?) = help
#-# rendering.transformation.icon.mappings = (on) = lightbulb
#-# rendering.transformation.icon.mappings = (off) = lightbulb_off
#-# rendering.transformation.icon.mappings = (*) = star

#-------------------------------------------------------------------------------------
# LinkChecker Transformation
#-------------------------------------------------------------------------------------

#-# [Since 3.3M2]
#-# Defines the time (in ms) after which an external link should be checked again for validity.
#-# the default configuration is:
# rendering.transformation.linkchecker.timeout = 3600000

#-# [Since 5.3RC1]
#-# List of document references that are excluded from link checking, specified using regexes.
#-# the default configuration is:
# rendering.transformation.linkchecker.excludedReferencePatterns = .*:XWiki\.ExternalLinksJSON

#-------------------------------------------------------------------------------------
# Rendering Macros
#-------------------------------------------------------------------------------------

#-# Velocity Macro

#-# [Since 2.0M1]
#-# Defines which Velocity Filter to use by default. This offers the possibility to filter the Velocity macro content
#-# before and after the Velocity Engine execution.
#-# The following filters are available:
#-# - indent (the default): Remove all first whites spaces of lines to support source code indentation without
#-#          generating whitespaces in the resulting XDOM.
#-# - none: Doesn't change the content
#-# - html: Removes all leading and trailing white spaces and new lines. If you need a space you'll need to use
#-#         \$sp and if you need a new line you'll need to use \$nl
#-# rendering.macro.velocity.filter = indent

#-------------------------------------------------------------------------------------
# HTML Sanitization
#-------------------------------------------------------------------------------------

#-# [Since 14.6RC1]
#-# The HTML sanitization strategy to use for user-generated content to avoid JavaScript injection. The following
#-# strategies are available by default:
#-# - secure (default): Only allows known elements and attributes that are considered safe. The following options
#-#                     allow customizing its behavior.
#-# - insecure:         Allows everything including JavaScript. Use this only if you absolutely trust everybody who can
#-#                     write wiki syntax (in particular, all users, but also anonymous users commenting when enabled).
# xml.htmlElementSanitizer = secure

#-# [Since 14.6RC1]
#-# Comma-separated list of additional tags that should be allowed by the HTML sanitizer. These tags will be allowed
#-# in addition to the already extensive built-in list of tags that are considered safe. Use with care to avoid
#-# introducing security issues. By default, the following tags are allowed:
#-# HTML tags: https://github.com/xwiki/xwiki-commons/blob/99484d48e899a68a1b6e33d457825b776c6fe8c3/xwiki-commons-core/xwiki-commons-xml/src/main/java/org/xwiki/xml/internal/html/HTMLDefinitions.java#L63-L74
#-# SVG tags: https://github.com/xwiki/xwiki-commons/blob/b11eae9d82cb53f32962056b5faa73f3720c6182/xwiki-commons-core/xwiki-commons-xml/src/main/java/org/xwiki/xml/internal/html/SVGDefinitions.java#L91-L102
#-# MathML tags: https://github.com/xwiki/xwiki-commons/blob/b11eae9d82cb53f32962056b5faa73f3720c6182/xwiki-commons-core/xwiki-commons-xml/src/main/java/org/xwiki/xml/internal/html/MathMLDefinitions.java#L62-L64
# xml.htmlElementSanitizer.extraAllowedTags =

#-# [Since 14.6RC1]
#-# Comma-separated list of additional attributes that should be allowed by the HTML sanitizer. These attributes will
#-# be allowed in addition to the already extensive built-in list of attributes that are considered safe. This option
#-# is useful if your content uses attributes that are invalid in HTML. Use with care to avoid introducing security
#-# issues. By default, the following attributes are allowed:
#-# HTML attributes: https://github.com/xwiki/xwiki-commons/blob/99484d48e899a68a1b6e33d457825b776c6fe8c3/xwiki-commons-core/xwiki-commons-xml/src/main/java/org/xwiki/xml/internal/html/HTMLDefinitions.java#L76-L91
#-# SVG attributes: https://github.com/xwiki/xwiki-commons/blob/b11eae9d82cb53f32962056b5faa73f3720c6182/xwiki-commons-core/xwiki-commons-xml/src/main/java/org/xwiki/xml/internal/html/SVGDefinitions.java#L66-L89
#-# MathML attributes: https://github.com/xwiki/xwiki-commons/blob/b11eae9d82cb53f32962056b5faa73f3720c6182/xwiki-commons-core/xwiki-commons-xml/src/main/java/org/xwiki/xml/internal/html/MathMLDefinitions.java#L73-L79
#-# XML attributes: https://github.com/xwiki/xwiki-commons/blob/b11eae9d82cb53f32962056b5faa73f3720c6182/xwiki-commons-core/xwiki-commons-xml/src/main/java/org/xwiki/xml/internal/html/SecureHTMLElementSanitizer.java#L135
# xml.htmlElementSanitizer.extraAllowedAttributes =

#-# [Since 14.6RC1]
#-# Comma-separated list of tags that should be forbidden. This takes precedence over any tags allowed by default or
#-# configured above. This can be used, for example, to forbid video or audio elements.
# xml.htmlElementSanitizer.forbidTags =

#-# [Since 14.6RC1]
#-# Comma-separated list of attributes that should be forbidden. This takes precedence over any attributes allowed by
#-# default or configured above. This can be used, for example, to forbid inline styles by forbidding the "style"
#-# attribute.
# xml.htmlElementSanitizer.forbidAttributes =

#-# [Since 14.6RC1]
#-# If unknown protocols shall be allowed. This means all protocols like "xwiki:" will be allowed in links, however,
#-# script and data-URIs will still be forbidden (for data-URIs see also below).  By default, unknown protocols are
#-# allowed.
# xml.htmlElementSanitizer.allowUnknownProtocols = true

#-# [Since 14.6RC1]
#-# If unknown protocols are disallowed (see above), the (Java) regular expression URIs are matched against.
#-# The default values is ^(?:(?:f|ht)tps?|mailto|tel|callto|cid|xmpp):
# xml.htmlElementSanitizer.allowedUriRegexp = ^(?:(?:f|ht)tps?|mailto|tel|callto|cid|xmpp):

#-# [Since 14.6RC1]
#-# Comma-separated list of additional tags on which data-URIs should be allowed in "src", "xlink:href" or "href".
#-# Adding "a" here, for example, would allow linking to data-URIs which is disabled by default due to the potential of
#-# security issues. Modern browsers should mitigate them, though, see for example
#-# https://blog.mozilla.org/security/2017/11/27/blocking-top-level-navigations-data-urls-firefox-59/ so you could
#-# use this to allow defining images, PDF files or files to be downloaded inline as data-URIs in links.
# xml.htmlElementSanitizer.extraDataUriTags =

#-# [Since 14.6RC1]
#-# Comma-separated list of additional attributes that are considered safe for arbitrary content including
#-# script-URIs, on these attributes the above-mentioned URI-checks aren't used. Use with care to avoid introducing
#-# security issues.
# xml.htmlElementSanitizer.extraURISafeAttributes =

#-------------------------------------------------------------------------------------
# Cache
#-------------------------------------------------------------------------------------

#-# [Since 1.7M1]
#-# The standard cache component implementation to use (can be local or distributed depending on the implementation).
#-# The default standard cache implementation is Infinispan.
# cache.defaultCache = infinispan

#-# [Since 1.7M1]
#-# The local cache implementation to use.
#-# The default local cache implementation is Infinispan.
# cache.defaultLocalCache = infinispan/local

#-------------------------------------------------------------------------------------
# Settings for the OpenOffice server instance consumed by the OfficeImporter component
#-------------------------------------------------------------------------------------

#-# [Since 1.9M2]
#-# Type of the openoffice server instance used by officeimporter component.
#-# 0 - Internally managed server instance. (Default)
#-# 1 - Externally managed (local) server instance.
# openoffice.serverType = 0

#-# [Since 12.1RC1]
#-# Port numbers used for connecting to the openoffice server instance.
#-# For an internally managed server instance, it will create the process for all ports.
#-# For an externally managed server instance, only the first server port is taken into account.
# openoffice.serverPorts = 8100,8101

#-# [Since 1.9M2]
#-# If the openoffice server should be started / connected upon XE start.
#-# Default value is false
openoffice.autoStart=true

#-# [Since 1.8RC3]
#-# Path to openoffice installation (serverType:0 only).
#-# If no path is provided, a default value will be calculated based on the operating environment.
# openoffice.homePath = /opt/openoffice.org3/

#-# [Since 1.8RC3]
#-# Path to openoffice execution profile (serverType:0 only).
#-# If no path is provided, a default value will be calculated based on the operating environment.
# openoffice.profilePath = /home/user/.openoffice.org/3

#-# [Since 1.8RC3]
#-# Maximum number of simultaneous conversion tasks to be handled by a single openoffice process (serverType:0 only).
#-# Default value is 50
# openoffice.maxTasksPerProcess = 50

#-# [Since 1.8RC3]
#-# Timeout for conversion tasks (in milliseconds) (serverType:0 only).
#-# Default value is 60 seconds
# openoffice.taskExecutionTimeout = 60000

#-------------------------------------------------------------------------------------
# Velocity
#-------------------------------------------------------------------------------------

#-# [Since 2.0M1]
#-# Velocity Tools that will be available from your scripts. The format is
#-# velocity.tools = <name under which it'll be available in the context> = <class name>
#-# Default values (no need to add them)
#-#   velocity.tools = numbertool = org.xwiki.velocity.internal.XWikiNumberTool
#-#   velocity.tools = datetool = org.xwiki.velocity.internal.XWikiDateTool
#-#   velocity.tools = mathtool = org.xwiki.velocity.internal.XWikiMathTool
#-#   velocity.tools = escapetool = org.apache.velocity.tools.generic.EscapeTool
#-#   velocity.tools = regextool = org.xwiki.velocity.tools.RegexTool
#-#   velocity.tools = collectiontool = org.xwiki.velocity.tools.CollectionTool
#-#   velocity.tools = stringtool = org.xwiki.text.StringUtils
#-#   velocity.tools = jsontool = org.xwiki.velocity.tools.JSONTool
#-#   velocity.tools = urltool = org.xwiki.velocity.tools.URLTool
#-#   velocity.tools = exceptiontool = org.apache.commons.lang3.exception.ExceptionUtils
#-#   velocity.tools = niotool = org.xwiki.velocity.tools.nio.NIOTool
#-#   velocity.tools = logtool = org.apache.velocity.tools.generic.LogTool
#-#   velocity.tools = objecttool = org.xwiki.velocity.tools.ObjectTool
#-#   velocity.tools = listtool = org.apache.velocity.tools.generic.ListTool (deprecated)
#-#   velocity.tools = sorttool = org.apache.velocity.tools.generic.SortTool (deprecated)
#-#   velocity.tools = collectionstool = org.xwiki.velocity.tools.CollectionsTool (deprecated)

#-# [Since 2.0M1]
#-# Velocity configuration properties. The format is
#-# velocity.properties = <Velocity property name> = <value>
#-# Default values (no need to add them)
#-#   velocity.properties = resource.loader = xwiki
#-#   velocity.properties = xwiki.resource.loader.class = org.xwiki.velocity.XWikiWebappResourceLoader
#-#   velocity.properties = velocimacro.library = "/templates/macros.vm"
#-#   velocity.properties = velocimacro.max_depth = 100
#-#   velocity.properties = resource.manager.log_when_found = false
#-#   velocity.properties = velocimacro.inline.local_scope = true
#-#   velocity.properties = velocimacro.inline.replace_global = true
#-#   velocity.properties = directive.if.empty_check = false
#-#   velocity.properties = parser.space_gobbling = bc
#-#   velocity.properties = parser.allow_hyphen_in_identifiers = true
#-#   velocity.properties = velocimacro.enable_bc_mode = true
#-#   velocity.properties = context.scope_control.template = true
#-#   velocity.properties = context.scope_control.macro = true
#-#   velocity.properties = event_handler.include.class = org.xwiki.velocity.internal.util.RestrictParseLocationEventHandler
#-#   velocity.properties = runtime.introspection.uberspect = org.xwiki.velocity.introspection.SecureUberspector\,org.apache.velocity.util.introspection.DeprecatedCheckUberspector\,org.xwiki.velocity.introspection.MethodArgumentsUberspector\,org.xwiki.velocity.introspection.MethodOverrideUberspector

#-------------------------------------------------------------------------------------
# Groovy
#-------------------------------------------------------------------------------------

#-# [Since 4.1M1]
#-# Allows to specify Compiler customization for the Groovy execution engine.
#-# There's no customizers defined by default. Available customizer ids:
#-# - timedinterrupt: interrupt script execution if it takes longer than a given time (default to 1 minute)
#-# - secure: runs Groovy in a security sandbox
#-# groovy.compilationCustomizers = <list of customizer ids here>

#-# Timed Interrupt Customizer

#-# [Since 4.1M1]
#-# Default execution time for a script before a timeout occurs, in seconds.
#-# groovy.customizer.timedInterrupt.timeout = 60

#-------------------------------------------------------------------------------------
# Events distribution
#-------------------------------------------------------------------------------------

#-# [Since 2.0M3]
#-# Indicate if the network distribution module is enabled or not.
#-# By default remote events are disabled.
# observation.remote.enabled = false

#-# [Since 2.0M3]
#-# The list of events communication channels to start when the application starts.
#-# By default no channel is configured.
#-#
#-# The default remote event distribution implementation is using JGroups and you'll need to either use embedded
#-# JGroups configuration files or drop your custom configuration in the WEB-INF/observation/remote/jgroups/ directory.
#-# There's a README file in that directory with more information.
#-# Example: observation.remote.channels = public, cluster

#-# [Since 2.0M4]
#-# The implementation of network adapter to use.
#-# The default is jgroups.
#-#
#-# By default only jgroups is provided. To add one implements NetworkAdaptor component interface. The identifier
#-# provided in the configuration is matched with the component role hint.
#-# Example: observation.remote.networkadapter = jgroups

#-------------------------------------------------------------------------------------
# CSRF token component
#-------------------------------------------------------------------------------------

#-# [Since 2.5M2]
#-# Controls whether secret token validation mechanism should be used (to prevent CSRF attacks).
#-#
#-# If enabled, all actions requiring "comment", "edit", "delete", "admin" or "programming" rights
#-# will check that the parameter "form_token" with the value of a random secret token is present
#-# in the request.
#-#
#-# Valid values:
#-#   true : Enabled
#-#   false: Disabled
#-#
#-# Default value is true
# csrf.enabled = true

#-------------------------------------------------------------------------------------
# Jobs
#-------------------------------------------------------------------------------------

#-# [Since 4.0M1]
#-# The folder containing job executing status.
#-# The default is {environment.permanentDirectory}/jobs/
# job.statusFolder = /var/lib/xwiki/data/jobs/

#-# [Since 7.2M2]
#-# The maximum number of entries to put in the job status cache.
#-# The default is 50.
# job.statusCacheSize = 50

#-# [Since 12.5RC1]
#-# The maximum number of entries to put in cache for the GroupedJobInitializer components.
#-# The default is 100.
# job.groupedJobInitializerCacheSize = 100

#-# [Since 12.5RC1]
#-# The thread keep-alive time in milliseconds for the single job executor.
#-# This value defines how long a thread can be idle before being terminated by the executor.
#-# The default value is 60000 for 60 000ms.
# job.singleJobThreadKeepAliveTime = 60000

#-# [Since 12.5RC1]
#-# The thread keep-alive time in milliseconds for the grouped job executors.
#-# This value defines how long a thread can be idle before being terminated by an executor.
#-# The default value is 60000 for 60 000ms.
# job.groupedJobThreadKeepAliveTime = 60000

#-------------------------------------------------------------------------------------
# Extension Manager
#-------------------------------------------------------------------------------------

#-# [Since 2.5]
#-# Repositories to use when searching and downloading extensions.
#-# Repositories will be checked in the same order they have in this configuration file.
#-#
#-# The format is <id>:<type>:<url> where
#-# * id can be anything as long as there is only one
#-# * type is the type of the repository (maven, xwiki, etc.)
#-# * url is the URL or the root of the repository
#-#
#-# [Since 4.3] It's also possible to associate various properties to each repository.
#-# Here are the standard properties:
#-# * user: the user to use to authenticate to the repository
#-# * password: the password to use to authenticate to the repository
#-# 
#-# And here those for "maven" repositories:
#-# * [Since 10.7RC1] checksumPolicy: what to do when checksum validation fail. Possible values are "fail", "warn"
#-#   (the default) and "ignore"
#-# * [Since 13.0RC1] http.headers: Custom HTTP headers to be used when connecting to the maven repository.
#-#
#-# Here is an example:
# extension.repositories = privatemavenid:maven:http://host.com/private/maven/
# extension.repositories.privatemavenid.auth.user = someuser
# extension.repositories.privatemavenid.auth.password = thepassword
# extension.repositories.privatemavenid.http.headers.headername = headervalue
#-#
#-# Here's an example to add your local Maven Repository
# extension.repositories = maven-local:maven:file://${sys:user.home}/.m2/repository
#-#
#-# And an example to add the XWiki Maven Snapshot Repository
# extension.repositories = maven-xwiki-snapshot:maven:https://nexus.xwiki.org/nexus/content/groups/public-snapshots
#-#
#-# When not set the following is taken (in this order):
# extension.repositories = maven-xwiki:maven:https://nexus.xwiki.org/nexus/content/groups/public
# extension.repositories = store.xwiki.com:xwiki:https://store.xwiki.com/xwiki/rest/
# extension.repositories = extensions.xwiki.org:xwiki:https://extensions.xwiki.org/xwiki/rest/
#-#
#-# To not have any repository enabled (including disabling default repositories) you can explicitly make this list
#-# empty:
# extension.repositories=

#-# [Since 2.5]
#-# The directory where extensions are stored after being downloaded.
#-#
#-# The default is extension/repository in whatever is the general persistent directory.
#-# See container.persistentDirectory.
# extension.localRepository=extension/repository

#-# [Since 3.4]
#-# The user agent to use when communication with external services (generally repositories).
#-#
#-# The default is:
# extension.userAgent=XWikiExtensionManager

#-# [Since 7.1RC1]
#-# Some extensions considered now as flavor but released before the category exists
#-#
extension.oldflavors=org.xwiki.enterprise:xwiki-enterprise-ui-mainwiki
extension.oldflavors=org.xwiki.enterprise:xwiki-enterprise-ui-wiki
extension.oldflavors=org.xwiki.manager:xwiki-manager-ui
extension.oldflavors=org.xwiki.manager:xwiki-manager-wiki-administrator
extension.oldflavors=org.xwiki.manager:xwiki-enterprise-manager-wiki-administrator
extension.oldflavors=com.xpn.xwiki.products:xwiki-enterprise-manager-wiki-administrator
extension.oldflavors=com.xpn.xwiki.products:xwiki-enterprise-wiki

#-# [Since 8.3]
#-# Indicate if XWiki should try to find more informations about the core extension in the repositories.
#-#
#-# The default is:
# extension.core.resolve=true

#-# [Since 9.6]
#-# Indicate a list of pattern extension ids and the corresponding recommended version.
#-# This version will be used for dependencies matching the pattern and fallback on the version declared by the
#-# extension in case of failure.
#-#
#-# Here is an example:
# extension.recommendedVersions=org.xwiki.commons:.*/[9.6]
# extension.recommendedVersions=org.xwiki.rendering:.*/[9.6]
# extension.recommendedVersions=org.xwiki.platform:.*/[9.6]
# extension.recommendedVersions=com.mygroupid:.*/[1.9]

#-# [Since 9.9]
#-# Indicate whether the server should automatically check for new available environment versions.
#-#
#-# The default is:
# extension.versioncheck.environment.enabled=false
#-#
#-# If the version check is enabled (through extension.versioncheck.environment.enabled), the following properties
#-# can be used to customize how the version check is performed.
#-#
#-# Indicate the number of seconds between each check for a new version of the server.
#-# The default is:
# extension.versioncheck.environment.interval=3600
#-#
#-# Indicate a pattern that will be used to filter which version should be considered as a new version.
#-# By default, no pattern is given an the pattern is not applied.
#-# Example:
# extension.versioncheck.environment.allowedVersions=9.*

#-# [Since 10.5RC1]
#-# Indicate how extension documents are protected.
#-#
#-# The possible choices are:
#-# * none: no protection at all
#-# * warning (the default): everyone get a warning when trying to edit a protected document
#-# * deny = EDIT/DELETE right is denied for everyone except for admins who just get a warning
#-# * forcedDeny = EDIT/DELETE right is denied for everyone, admins can't force edit/delete
#-# * denySimple = EDIT/DELETE right is denied for simple users except for simple admins who just get a warning
#-# * forcedDenySimple = EDIT/DELETE right is denied for all simple users, simple admins can't force edit/delete
# extension.xar.protection=warning

#-# [Since 12.2RC and 11.10.4]
#-# Indicate a list of extension dependencies to ignore
#-# 
#-# The default list is:
# extension.ignoredDependencies=stax:stax
# extension.ignoredDependencies=javax.xml.stream:stax-api
# extension.ignoredDependencies=stax:stax-api
# extension.ignoredDependencies=xalan:xalan
# extension.ignoredDependencies=xalan:serializer
# extension.ignoredDependencies=xml-apis:xml-apis
# extension.ignoredDependencies=xerces:xmlParserAPIs

#-------------------------------------------------------------------------------------
# Extension Manager - Security
#-------------------------------------------------------------------------------------

#-# [Since 15.5RC1]
#-# When true, the security scan is enabled. This is the default; set to false to disable the scan.
#-#
# extension.security.scan.enabled = true

#-# [Since 15.5RC1]
#-# Specifies the delay before starting a new security scan after the last one has finished.
#-# The default value is 24 hours.
#-#
# extension.security.scan.delay = 24

#-# [Since 15.5RC1]
#-# Specifies the url to use as the endpoint for the security scan rest queries.
#-# The url must conform to the API documented here: https://google.github.io/osv.dev/post-v1-query/
#-# The default value is https://api.osv.dev/v1/query.
#-#
# extension.security.scan.url = https://api.osv.dev/v1/query

#-# [Since 15.6RC1]
#-# Specifies the url to use as the endpoint for the security scan false-positive fetching rest queries.
#-# The url must conform to the API documented here: http://e.x.o.doc...
#-# The default value is https://extensions.xwiki.org/xwiki/bin/view/Extension/Extension/Security/Code/Reviews
#-#
# extension.security.reviews.url = https://extensions.xwiki.org/xwiki/bin/view/Extension/Extension/Security/Code/Reviews

#-------------------------------------------------------------------------------------
# Distribution Wizard
#-------------------------------------------------------------------------------------

#-# [Since 7.1RC1] Enable or disable the automatic start of Distribution Wizard on empty/outdated wiki.
#-#
#-# The default is:

# distribution.automaticStartOnMainWiki=true
# distribution.automaticStartOnWiki=true

#-# [Since 10.2RC1] Control if the Distribution Wizard should be automatic or interactive (the default)
#-# 
#-# On the main wiki
# distribution.job.interactive=true
#-# On the subwikis
# distribution.job.interactive.wiki=true

#-# [Since 10.2RC1] Override the default UI indicated in the "environment extension" (usually means the WAR).
#-# It usually make more sense to set that at the WAR level (since it's usually synchronized with it).
#-# If this is set it also means the Distribution Wizard will switch to default UI mode in which you cannot choose the
#-# flavor.
#-#
#-# The id[/version] of the default UI for the main wiki. If the version is not indicated it will be the version of the
#-# environment extension.
# distribution.defaultUI=org.my.groupid:artifactid-mainwiki/1.5
#-# The id[/version] default UI for the subwikis.  If the version is not indicated it will be the version of the
#-# environment extension.
# distribution.defaultWikiUI=org.my.groupid:artifactid-wiki/1.5

#-------------------------------------------------------------------------------------
# Solr Search
#-------------------------------------------------------------------------------------

#-# [Since 4.5M1]
#-# The Solr server type. Currently accepted values are "embedded" (default) and "remote".
# solr.type=embedded

#-# [Since 4.5M1]
#-# The location where the embedded Solr instance home folder is located.
#-# The default is the subfolder "store/solr" inside folder defined by the property "environment.permanentDirectory".
# solr.embedded.home=/var/local/xwiki/store/solr

#-# [Since 12.2]
#-# The URL of the Solr server (the root server and not the URL of a core).
#-# The default value assumes that the remote Solr server is started in a different process on the same machine,
#-# using the default port.
# solr.remote.baseURL=http://localhost:8983/solr

#-# [Since 12.6]
#-# The prefix to add in front on each remote core name to avoid collisions with non-XWiki cores.
#-# The default is "xwiki" which will produce names likes "xwiki_events" for example.
# solr.remote.corePrefix=xwiki

#-# [Since 5.1M1]
#-# Elements to index are not sent to the Solr server one by one but in batch to improve performances.
#-# It's possible to configure this behavior with the following properties:
#-#
#-# The maximum number of elements sent at the same time to the Solr server
#-# The default is 50.
# solr.indexer.batch.size=50
#-# The maximum number of characters in the batch of elements to send to the Solr server.
#-# The default is 10000.
# solr.indexer.batch.maxLength=10000

#-# [Since 5.1M1]
#-# The maximum number of elements in the background queue of elements to index/delete
#-# The default is 10000.
# solr.indexer.queue.capacity=100000

#-# [Since 6.1M2]
#-# Indicates if a synchronization between SOLR index and XWiki database should be performed at startup.
#-# Synchronization can be started from the search administration UI.
#-# The default is true.
# solr.synchronizeAtStartup=false

#-# [Since 12.5RC1]
#-# Indicates which wiki synchronization to perform when the "solr.synchronizeAtStartup" property is set to true.
#-# Two modes are available:
#-#   - WIKI: indicate that the synchronization is performed when each wiki is accessed for the first time.
#-#   - FARM: indicate that the synchronization is performed once for the full farm when XWiki is started.
#-# For large farms and in order to spread the machine's indexing load, the WIKI value is recommended, especially if
#-# some wikis are not used.
#-# The default is:
# solr.synchronizeAtStartupMode=FARM

#-------------------------------------------------------------------------------------
# Security
#-------------------------------------------------------------------------------------

#-# [Since 5.0M2]
#-# Define the authorization policies by choosing another implementation of the AuthorizationSettler. This component
#-# is solely responsible for settling access decisions based on user, target entity and available security rules.
#-# The identifier provided here is matched with the component role hint.
#-#
#-# The default is:
# security.authorization.settler = default

#-# [Since 13.0]
#-# Control if document save API should also check the right of the script author when saving a document.
#-# When false only the current user right is checked.
#-#
#-# The default is:
# security.script.save.checkAuthor = true

#-# [Since 13.10]
#-# Prevent against DOS attacks by limiting the number of entries returned by DB queries, for guest users.
#-#
#-# The default is:
# security.queryItemsLimit = 100

#-# [Since 13.10.1]
#-# [Since 14.0RC1]
#-# Define the lifetime of the token used for resetting passwords in minutes. Note that this value is only used after
#-# first access.
#-# Default value is 0 meaning that the token is immediately revoked when first accessed.
#-# Use a different value if the reset password email link might be accessed several times (e.g. in case of using an
#-# email link verification system): in such case the user will have the defined lifetime to use again the email link.
#-#
#-# The default is:
# security.authentication.resetPasswordTokenLifetime = 0

#-# [Since 14.6RC1]
#-# [Since 14.4.3]
#-# [Since 13.10.8]
#-# This option is only used when performing a migration from a wiki before the versions mentioned above.
#-#
#-# This parameter defines if as part of the migration R140600000XWIKI19869 the passwords of impacted user should be
#-# reset or not. It's advised to keep this value as true, now for some usecases advertised administrators might want
#-# their users to keep their passwords nevertheless, then enable the configuration and set it to false before the
#-# migration is executed.
# security.migration.R140600000XWIKI19869.resetPassword = true

#-# [Since 14.6RC1]
#-# [Since 14.4.3]
#-# [Since 13.10.8]
#-# This option is only used when performing a migration from a wiki before the versions mentioned above.
#-#
#-# This parameter defines if reset password emails should be sent as part of the migration R140600000XWIKI19869.
#-# By default this value is set to true, so emails will be automatically produced. Now it's possible for admin to set
#-# this option to false: note that in such case a file containing the list of users for whom a reset password email
#-# should be sent will still be created in the permanent directory (named 140600000XWIKI19869DataMigration-users.txt).
#-# If this file exists and this property is set back to true after the migration, the file will still be consumed to
#-# send the emails, so it's possible to perform the migration and send the emails only later if needed.
# security.migration.R140600000XWIKI19869.sendResetPasswordEmail = true

#-# [Since 14.6RC1]
#-# [Since 14.4.3]
#-# [Since 13.10.8]
#-# This option is only used when performing a migration from a wiki before the versions mentioned above.
#-#
#-# This parameter defines if a security email information should be sent as part of the migration R140600000XWIKI19869.
#-# By default this value is set to true, so emails will be automatically produced. Now it's possible for admin to set
#-# this option to false: note that in such case a file containing the list of users for whom a reset password email
#-# should be sent will still be created in the permanent directory (named 140600000XWIKI19869DataMigration-users.txt).
#-# If this file exists and this property is set back to true after the migration, the file will still be consumed to
#-# send the emails, so it's possible to perform the migration and send the emails only later if needed.
# security.migration.R140600000XWIKI19869.sendSecurityEmail = true

#-# [Since 15.9RC1]
#-# Indicates how documents are protected by required rights.
#-#
#-# The possible choices are:
#-# * none: no required rights check
#-# * warning (the default): a warning is presented to the user when trying to edit a document with required rights
#-# issues
# security.requiredRights.protection=warning

#-------------------------------------------------------------------------------------
# URL
#-------------------------------------------------------------------------------------

#-# IMPORTANT: The URL module is a feature still in development and as such should be considered experimental at the
#-# moment. The configuration parameters below are used only in some part of the code at the moment. The idea is to
#-# progressively refactor more and more till only the new properties are used. For the moment you should continue to
#-# use the following old properties located in xwiki.cfg:
#-#  xwiki.virtual.usepath
#-#  xwiki.virtual.usepath.servletpath

#-# [Since 5.1M1]
#-# The id of the URL format to use. This allows to plug in different implementations and thus allows to completely
#-# control the format of XWiki URLs.
#-#
#-# The default is:
# url.format=standard

#-# [Since 5.1M1]
#-# Defines where the wiki part is defined in a URL pointing to a subwiki
#-# If true then the wiki part is located in the URL path (a.k.a path-based), for example:
#-#   http://server/xwiki/wiki/mywiki/view/Space/Page
#-# If false then the wiki part is located in the URL host domain (a.k.a domain-based), for example:
#-#   http://mywiki.domain/xwiki/bin/view/Space/Page
#-#
#-# The default is:
# url.standard.multiwiki.isPathBased=true

#-# [Since 5.1M1]
#-# For path-based setups, this property defines the path segment before the one identifying the subwiki in the URL.
#-# For example if set to "thewiki", then the following URL will point to a subwiki named "mywiki":
#-#   http://server/xwiki/thewiki/mywiki/view/Space/Page
#-# Note that the mapping in web.xml has to be modified accordingly if you don't use the default value:
#-#   <servlet-mapping>
#-#     <servlet-name>action</servlet-name>
#-#     <url-pattern>/wiki/*</url-pattern>
#-#   </servlet-mapping>
#-#
#-# The default is:
# url.standard.multiwiki.wikiPathPrefix=wiki

#-# [Since 5.2M1]
#-# Defines the URL path prefix used for Entity URLs, i.e. URLs pointing to a Document, Space, Object, etc.
#-# For example this is the "bin" part in the following URL:
#-#   http://server/xwiki/bin/view/space/page
#-# Note that this replaces the old xwiki.defaultservletpath property in the xwiki.cfg file.
#-#
#-# The default is:
# url.standard.entityPathPrefix=bin

#-# [Since 5.3M1]
#-# The action to take when a subwiki is not found (ie there's no wiki descriptor for it). Valid values are:
#-# - redirect_to_main_wiki: default to displaying the main wiki
#-# - display_error: redirect to a vm to display an error
#-#
#-# The default is:
# url.standard.multiwiki.notFoundBehavior=redirect_to_main_wiki

#-# [Since 7.2M1]
#-# Whether the "view" action is omitted in URLs (in order to have shorter URLs).
#-# Note that this replaces the old xwiki.showviewaction property in the xwiki.cfg file.
#-#
#-# The default is:
# url.standard.hideViewAction=false

#-# [Since 11.1RC1]
#-# Whether a the last modified date of the file to be loaded should be checked and put in the URL query parameter.
#-# Disabling this might improve a bit the performance on some old hard drives, or custom filesystem, however
#-# it might imply the need to force-reload some resources in the browser, when migrating.
#-#
#-# The default is:
# url.useResourceLastModificationDate=true

#-# [Since 13.3RC1]
#-# [Since 12.10.7]
#-# Define a list of trusted domains that can be used in the wiki for performing requests or redirections even if
#-# the wiki does not use it. Domains are listed without http and separated with a comma in the list. Subdomains can be
#-# specified.
#-# Example of accepted value: foo.acme.org,enterprise.org
#-#
#-# By default the list of trusted domains is empty:
# url.trustedDomains=
########################################
# Modifica el contexto.
# Valor anterior, comentado
# url.trustedDomains=
url.trustedDomains=www-pre.gobiernodecanarias.org
########################################

#-# [Since 13.3RC1]
#-# [Since 12.10.7]
#-# Allow to enable or disable checks performed on domains by taking into account the list of trusted domains.
#-# Disable this property only if you experienced some issues on your wiki: some security check won't be performed when
#-# this property is set to false.
#-#
#-# By default this property is set to true:
# url.trustedDomainsEnabled=true
url.trustedDomainsEnabled=false

#-# [Since 15.0]
#-# [Since 14.10.4]
#-# Define the list of schemes that are allowed for trusted URIs. Those schemes are checked whenever an absolute URI
#-# needs to be checked (e.g. before performing a redirect). Any URI whose scheme doesn't belong to that list will not
#-# be considered trustful, even if the domain of the URI is trusted.
#-# Also note that even if a protocol is added here to be trusted, it might need a custom protocol handler. By default,
#-# only http,https,ftp and file protocols are handled.
#-#
#-# The default is:
# url.trustedSchemes=http,https,ftp

#-------------------------------------------------------------------------------------
# Attachment
#-------------------------------------------------------------------------------------

#-# [Since 5.2M2]
#-# Define the kind of attachment that can be displayed inline. You can either choose to do it through a whitelist
#-# (only the mimetypes defined in this list would be displayed inline) or a blacklist (every mimetype that is not in
#-# this list would be displayed inline if possible).
#-# Note that only one configuration is used between the whitelist and the blacklist, and the whitelist always have
#-# the priority over the blacklist. Also note that these configurations exist for security reason so they are only
#-# impacting attachments added by users who do not have programming rights.
#-# If you want to force downloading some attachments types please check the configuration below.
#-#
#-# By default we use the following whitelist (coma separated list of values).
# attachment.download.whitelist=audio/basic,audio/L24,audio/mp4,audio/mpeg,audio/ogg,audio/vorbis,audio/vnd.rn-realaudio,audio/vnd.wave,audio/webm,image/gif,image/jpeg,image/pjpeg,image/png,image/tiff,text/csv,text/plain,text/xml,text/rtf,video/mpeg,video/ogg,video/quicktime,video/webm,video/x-matroska,video/x-ms-wmv,video/x-flv
#-#
#-# If you prefer to use a blacklist instead, you can define the forbidden types here, as a coma separated list of
#-# values. We advise you to forbid at least the following mimetypes : text/html, text/javascript
# attachment.download.blacklist=text/html,text/javascript

#-# [Since 12.10]
#-# Define the kind of attachment that you always want to be downloaded and never displayed inline.
#-# By default this list is empty, but you can specify a list of mime-types (coma separated list of values) which
#-# should be always downloaded no matter who attached them or what is the whitelist/blacklist configuration.
#-#
#-# The distinction with the blacklist configuration above is that the blacklist won't affect file attached by a user
#-# with programming rights, while this configuration affect any attachment.
# attachment.download.forceDownload=

#-# [Since 14.10]
#-# Define the list of allowed attachment mimetypes. By default, this list is empty, but you can specify a 
#-# comma-separated list of allowed mimetypes. Note that a single star character (*) can be used in the defined allowed
#-# mimetype and in this case the allowed mimetype value will need to start with the text before the star and end with
#-# the text after it.
#-# Once this list is not empty, any attachment with an unlisted mimetype will be rejected.
#-# For instance, if you want to only accept plain text and any kind of images, you can set the list to:
#-# text/plain,image/*
# attachment.upload.allowList=

#-# [Since 14.10]
#-# Define the list of blocked attachment mimetypes. By default, this list is empty, but you can specify a 
#-# comma-separated list of blocked mimetypes. Note that a single star character (*) can be used in the defined blocked
#-# mimetype and in this case the blocked mimetype value will need to start with the text before the star and end with
#-# the text after it.
#-# Once this list is not empty, any attachment matching one of the listed mimetype will be rejected.
#-# For instance, if you want to reject plain text and any kind of images, you can set the list to:
#-# text/plain,image/*
#-#
# attachment.upload.blockList=

#-------------------------------------------------------------------------------------
# Active Installs 2
#-------------------------------------------------------------------------------------

#-# [Since 14.5]
#-# The URL of where the Active Installs 2 module should connect to, in order to send a ping of activity. This feature
#-# regularly sends anonymous information to xwiki.org about the current instance.
#-# The goal is to count the number of active installs of XWiki out there and provide statistics on xwiki.org
#-#
#-# The default is:
# activeinstalls2.pingURL = https://extensions.xwiki.org/activeinstalls2

#-# [Since 14.5]
#-# Default user agent used when sending pings.
#-# The default is:
# activeinstalls2.userAgent = XWikiActiveInstalls2

#-------------------------------------------------------------------------------------
# Wikis
#-------------------------------------------------------------------------------------

#-# [Since 5.4.4]
#-# Add a default suffix to the alias of a new wiki in the wiki creation wizard, only when the path mode is not used
#-# (i.e. domain-based, see url.standard.multiwiki.isPathBased). If this value is empty, XWiki will try to compute it
#-# automatically from the request URL.
#-#
#-# eg: if wiki.alias.suffix is "xwiki.org" and the wiki name is "playground"
#-#     then the computed alias will be: "playground.xwiki.org".
#-#
#-# The default is:
# wiki.alias.suffix=

#-# [Since 14.9RC1]
#-# Allows delegating the database/schema/user creation (depends on the database) for a new wiki to an infra admin.
#-# Said differently, if the following property is false then XWiki will not create any database/schema/user when
#-# creating a wiki. It's assumed that it will exist prior to using the Wiki creation wizard.
#-#
#-# The default is:
# wiki.createDatabase = true

#-------------------------------------------------------------------------------------
# Store
#-------------------------------------------------------------------------------------

#-# [Since 6.1M2]
#-# If active, the Filesystem Attachment Store will automatically clear empty directories on startup,
#-# in some cases this may create undue load on the server and may need to be disabled. To do that,
#-# set the following to false.
#-# Note that if you disable this feature, empty directories will accumulate and you are responsible
#-# for cleaning them up.
# store.fsattach.cleanOnStartup=true

#-# [Since 11.4RC1]
#-# The root directory used by the various "file" stores implementation (attachment, deleted document, etc.).
#-# 
#-# The default is ${environment.permanentDirectory}/store/file.
# store.file.directory=/var/lib/xwiki/data/store/file/

#-------------------------------------------------------------------------------------
# Mail
#-------------------------------------------------------------------------------------

#-# [Since 6.1M2]
#-# SMTP host when sending emails, defaults to "localhost".
#-# This configuration property can be overridden in XWikiPreferences objects, by using the "smtp_server" property name.
# mail.sender.host = localhost

#-# [Since 6.1M2]
#-# SMTP port when sending emails, defaults to 25.
#-# This configuration property can be overridden in XWikiPreferences objects, by using the "smtp_port" property name.
# mail.sender.port = 25

#-# [Since 6.1M2]
#-# From email address to use. Not defined by default and needs to be set up when calling the mail API.
#-# This configuration property can be overridden in XWikiPreferences objects, by using the "admin_email" property name.
# mail.sender.from = john@doe.com

#-# [Since 6.1M2]
#-# Username to authenticate on the SMTP server, if needed. By default no authentication is performed.
#-# This configuration property can be overridden in XWikiPreferences objects, by using the "smtp_server_username"
#-# property name.
# mail.sender.username = someuser

#-# [Since 6.1M2]
#-# Password to authenticate on the SMTP server, if needed. By default no authentication is performed.
#-# This configuration property can be overridden in XWikiPreferences objects, by using the "smtp_server_password"
#-# property name.
# mail.sender.password = somepassword

#-# [Since 6.1M2]
#-# Extra Java Mail options (see https://javamail.java.net/nonav/docs/api/).
#-# This configuration property can be overridden in XWikiPreferences objects, by using the "javamail_extra_props"
#-# property name.
#-# By default the following properties are set automatically:
#-#   mail.transport.protocol = smtp
#-#   mail.smtp.host = <value of the mail.sender.host property>
#-#   mail.smtp.port = <value of the mail.sender.port property>
#-#   mail.smtp.user = <value of the mail.sender.username property>
#-#   mail.smtp.from = <value of the mail.sender.from property>
#-# Example:
# mail.sender.properties = mail.smtp.starttls.enable = true
# mail.sender.properties = mail.smtp.socks.host = someserver

#-# [Since 6.4M2]
#-# Defines which authorization checks are done when sending mails using the Mail Sender Script Service.
#-# Example of valid values:
#-# - "programmingrights": the current document must have Programming Rights
#-# - "alwaysallow": no check is performed. This is useful when running XWiki in a secure environment where we
#-#   want to allow all users to be able to send emails through the Script Service.
#-# The default is:
# mail.sender.scriptServiceCheckerHint = programmingrights

#-# [Since 6.4M2]
#-# optional default email addresses to add to the BCC mail header when sending email.
# mail.sender.bcc = john@doe.com,mary@doe.com

#-# [Since 6.4RC1]
#-# The delay to wait between each mail being sent, in milliseconds. This is done to support mail throttling and not
#-# be considered a spammer by mail servers.
#-# The default is 8 seconds:
# mail.sender.sendWaitTime = 8000

#-# [Since 6.4.1, 7.0M1]
#-# When using the Database Mail Listener, whether mail statuses for mails that have been sent successfully must be
#-# discarded or not. They could be kept for tracability purpose for example.
#-# The default is:
# mail.sender.database.discardSuccessStatuses = true

#-# [Since 11.6RC1]
#-# Max queue size for the prepare mail thread. When the max size is reached, asynchronously sending a mail will block
#-# till the first mail item in the prepare queue has been processed.
# mail.sender.prepareQueueCapacity = 1000

#-# [Since 11.6RC1]
#-# Max queue size for the send mail thread. When the max size is reached, the prepare queue will block till the first
# mail item in the send queue has been sent.
# mail.sender.sendQueueCapacity = 1000

#-------------------------------------------------------------------------------------
# Debug
#-------------------------------------------------------------------------------------

#-# [Since 7.0RC1]
#-# Indicate if web resources should be loaded minified by default.
#-# It's enabled by default which can make js/css hard to read.
# debug.minify=false

#-------------------------------------------------------------------------------------
# LESS CSS
#-------------------------------------------------------------------------------------

#-# [Since 7.4.2, 8.0M2]
#-# The number of LESS compilations that can be performed simultaneously. Put a little number if your resources are
#-# limited.
#-#
#-# The default is:
# lesscss.maximumSimultaneousCompilations = 4

#-# [Since 8.0RC1]
#-# Generate sourcemaps inline in the CSS files.
#-#
#-# The default is:
# lesscss.generateInlineSourceMaps = false

#-------------------------------------------------------------------------------------
# Edit
#-------------------------------------------------------------------------------------

#-# [Since 8.2RC1]
#-# Indicate the default editor to use for a specific data type.
#-# The editors are components so they are specified using their role hints.
#-# Some data types can be edited in multiple ways, by different types of editors.
#-# Thus you can also indicate the default editor to use from a specific category (editor type).
#-#
#-# The format is this:
#-# edit.defaultEditor.<dataType>=<roleHintOrCategory>
#-# edit.defaultEditor.<dataType>#<category>=<roleHintOrSubCategory>
#-#
#-# The default bindings are:
# edit.defaultEditor.org.xwiki.rendering.syntax.SyntaxContent=text
# edit.defaultEditor.org.xwiki.rendering.syntax.SyntaxContent#text=text
# edit.defaultEditor.org.xwiki.rendering.block.XDOM=text
# edit.defaultEditor.org.xwiki.rendering.block.XDOM#text=text

#-# [Since 11.3.2, 11.6RC1]
#-# Indicate if the mechanism to detect and handle edition conflicts should be enabled or not.
#-# If disabled, it means that in case of edition conflicts, the latest save will be always take into account, and
#-# erase previous data (which can always be recovered in the history of the document).
#-# This option is provided because the feature is still experimental and it could be useful is some specific usecases
#-# to switch it off. However it is not recommended to do so.
#-#
#-# The default is:
# edit.conflictChecking.enabled = true

#-# [Since 12.5]
#-# Indicate if the XWiki documents should be edited in-place, without leaving the view mode, whenever possible (e.g. if
#-# the default edit mode for that document and the preferred editor both support in-place editing). When enabled,
#-# clicking on the document Edit button makes the document title and content editable in-place, without leaving the
#-# view mode. When disabled, clicking on the document Edit button loads the default (stand-alone) edit mode for that
#-# document.
#-#
#-# The default is:
# edit.document.inPlaceEditing.enabled = true

#-------------------------------------------------------------------------------------
# Notifications
#-------------------------------------------------------------------------------------

#-# [Since 9.4RC1]
#-# Indicates if the notifications module should be enabled on the platform.
#-#
#-# The default is :
# notifications.enabled = true

#-# [Since 9.5C1]
#-# Indicates if the notifications module can send emails.
#-#
#-# The default is :
# notifications.emails.enabled = true

#-# [Since 9.6RC1]
#-# Indicate the grace time used when sending live email notifications.
#-# When an event is triggered in the wiki (for example, a document update), the platform will wait X minutes
#-# before sending live notifications emails. During this time, if events of the same kind are recieved, they will
#-# be grouped in the same email.
#-#
#-# The grace time define the period (in minutes) for which the platform should wait before sending a notification
#-# mail after an event.
#-#
#-# The default is :
# notifications.emails.live.graceTime = 10

#-# [Since 9.8RC1]
#-# Indicate if the "watched entities" feature is enabled on the platform.
#-# This feature mimics what the "Watchlist Application" does so it may not be a good idea to have both on the platform.
#-#
#-# The default is :
# notifications.watchedEntities.enabled = true

#-# [Since 9.11.8]
#-# [Since 10.6RC1]
#-# The automatic watch mode used by default. The value can be changed by an administrator in the wiki's administration
#-# or by any user in their own settings.
#-#
#-# Possible values:
#-#
#-# - none:  no page is added to the list of watched pages automatically.
#-# - all:   everytime a user makes a change on a page, it is automatically added to her list of watched pages.
#-# - major: everytime a user makes a major change on a page, it is automatically added to her list of watched pages.
#-# - new:   only pages created by a user are added to her list of watched pages.
#-#
#-# The default is :
# notifications.watchedEntities.autoWatch = major

#-# [Since 10.11.4]
#-# [Since 11.2]
#-# The search for notifications in the REST API is done trough a thread pool to limit the impact on the rest of the
#-# XWiki instance.
#-# This properties controls the size of this pool. Any number lower than 1 disable the thread pool system.
#-# 
#-# The default is :
# notifications.rest.poolSize = 2

#-# [Since 10.11.8]
#-# [Since 11.3]
#-# Enable or disable caching of notification search result in the REST or async API.
#-# 
#-# The default is :
# notifications.rest.cache = true

#-# [Since 12.5RC1]
#-# The async notifications renderer is using a dedicated thread pool to limit the impact on the rest of the XWiki
#-# instance.
#-# This properties controls the size of this pool.
#-#
#-# The default is :
# notifications.async.poolSize = 2

#-# [Since 15.5RC1]
#-# The hint of the strategy component to use for email grouping notifications. Default strategy is to group all
#-# notifications in a single email, but other strategies can be provided, e.g. to send as many emails as there was
#-# type of notifications. Check online documentation related to notification to see the list of available strategies.
#-#
#-# The default is :
# notifications.emailGroupingStrategyHint = "default"

#-------------------------------------------------------------------------------------
# Mentions
#-------------------------------------------------------------------------------------

#-# [Since 12.6]
#-# The detection and notification for the user mentions in created or edited content is done asynchronously 
#-# by a pool of consumers.
#-# This properties controls the size of this pool.
#-#
#-# The default is :
# mentions.poolSize = 1

#-------------------------------------------------------------------------------------
# Event Stream
#-------------------------------------------------------------------------------------

#-# [Since 11.1RC1]
#-# The Event Stream, on which the notifications are based, stores data in a dedicated table in the database.
#-# Each wiki has its own database. The feature can be configured to store its data into the database corresponding to
#-# the wiki, into the main database (default: xwiki) or both. These options should not be both set to false (in this
#-# case the local store will be forced).
#-# Important note: disabling storage in the main store will prevent the notifications from retrieving events from
#-# subwikis. Moreover, disabling the main store makes impossible for global users to watch pages from subwikis. It is
#-# not recommended.
#-#
#-# This feature was originally implemented by the Activity Stream plugin so these settings might sound familiar to you.
#-#
#-# The default is :
# eventstream.uselocalstore = true
#-#
#-# The default is :
# eventstream.usemainstore = true
#-#
#-# Number of days the events should be kept (0 or any negative value: infinite duration)
#-# Note: if this value is greater than 0 a scheduler job will be created, this job will then be fired every week to
#-# delete events older than the configured value.
#-# The default is :
# eventstream.daystokeepevents = 0

#-# [Since 12.4]
#-# Indicate if the new no-SQL oriented event store is enabled. Once enabled the Solr implementation is
#-# used by default but other implementations (like a MongoDB based implementation for example) might come later.
#-# It's enabled by default since 12.6.
# eventstream.store.enabled = true
#-# Indicate which event store implementation to use. The default implementation is based on Solr.
# eventstream.store = solr

#-------------------------------------------------------------------------------------
# Logging
#-------------------------------------------------------------------------------------

#-# [Since 12.0RC1]
#-# Indicate of logging about the use of deprecated APIs/feature should be enabled.
#-# 
#-# The default is:
# logging.deprecated.enabled = true

#-------------------------------------------------------------------------------------
# User
#-------------------------------------------------------------------------------------

#-# [Since 12.2]
#-# Indicate where users are stored.
#-#
#-# The default (and currently the only supported option) is:
# user.store.hint = document

#-# [Since 12.2]
#-# Define preferences for the SuperAdmin user.
#-#
#-# The format is:
#-# user.preferences.superadmin.<preference name> = <value>
#-#
#-# Values set by default for the SuperAdmin user:
#-# user.preferences.superadmin.displayHiddenDocuments = 1
#-# user.preferences.superadmin.active = 1
#-# user.preferences.superadmin.first_name = SuperAdmin
#-# user.preferences.superadmin.email_checked = 1
#-# user.preferences.superadmin.usertype = Advanced
#-#
#-# Examples:
#-# user.preferences.superadmin.displayHiddenDocuments = 0
#-# user.preferences.superadmin.editor = Text

#-# [Since 12.2]
#-# Define preferences for the Guest user.
#-#
#-# The format is:
#-# user.preferences.guest.<preference name> = <value>
#-#
#-# Values set by default for the Guest user:
#-# user.preferences.guest.displayHiddenDocuments = 0
#-# user.preferences.guest.active = 0
#-# user.preferences.guest.first_name = Guest
#-# user.preferences.guest.email_checked = 0
#-#
#-# Examples:
#-# user.preferences.guest.displayHiddenDocuments = 1
#-# user.preferences.guest.editor = Text

#-# [Since 14.10.12]
#-# [Since 15.5RC1]
#-# When displaying an user in a compact mode we usually rely only on the user avatar and their full name. If this is
#-# not enough to properly identify the user then this configuration can be used to display additional information.
#-#
#-# The name of the user property to be used as qualifier (hint) when displaying the user in a compact mode. This
#-# configuration is not set by default, which means no additional information is displayed:
# user.display.qualifierProperty =

#-------------------------------------------------------------------------------------
# Refactoring
#-------------------------------------------------------------------------------------

#-# [Since 12.9RC1]
#-# Indicates whether skipping the recycle bin when deleting pages is allowed for Advanced users.
#-# It is disabled by default.
#-# This setting is only used if the wiki has a recycle bin activated (xwiki.recyclebin=1 in xwiki.cfg).
#-# This setting can be overloaded:
#-# * By the main wiki in the Refactoring.Code.RefactoringConfigurationClass class of the
#-#   Refactoring.Code.RefactoringConfiguration document of the main wiki.
#-# * By sub-wikis in the Refactoring.Code.RefactoringConfigurationClass class of the
#-#   Refactoring.Code.RefactoringConfiguration document of the sub-wikis (itself overloading the main wiki's
#-#   configuration).
#-#
#-# The default value is:
# refactoring.isRecycleBinSkippingActivated = false

#-------------------------------------------------------------------------------------
# Skin Extensions
#-------------------------------------------------------------------------------------

#-# [Since 12.7.1, 12.8RC1]
#-# Indicate whether the JavaScript skin extensions should be parsed and minified using strict mode. When strict mode is
#-# enabled:
#-# * the JavaScript minification may fail if the code is poorly written. See
#-#   https://github.com/google/closure-compiler/wiki/Warnings for a list of errors that may occur. When this happens
#-#   XWiki uses the original (unminified) JavaScript source as a fall-back and logs some error messages that indicate
#-#   how the bad code can be fixed.
#-# * the minified JavaScript includes the "use strict;" statement which means the code may fail at runtime if it doesn't
#-#   follow the ECMAScript strict rules. See https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Strict_mode
#-#
#-# The default value is:
# skinx.jsStrictModeEnabled = false

#-------------------------------------------------------------------------------------
# Localization
#-------------------------------------------------------------------------------------

#-# [Since 14.10.2, 15.0RC1]
#-# Indicate whether translations with user scope that are only applied for the user who created them shall be
#-# restricted to users with script right. The default value is true. Disable this option only when you absolutely
#-# trust all users on the wiki.
# localization.wiki.restrictUserTranslations = true

#-------------------------------------------------------------------------------------
# PDF Export
#-------------------------------------------------------------------------------------

#-# [Since 14.4.3]
#-# [Since 14.6RC1]
#-# Whether the PDF export should be performed server-side, e.g. using a headless Chrome web browser running inside a
#-# Docker container, or client-side, using the user's web browser instead. Defaults to client-side PDF generation
#-# starting with 14.8
# export.pdf.serverSide = false

#-# The host running the headless Chrome web browser, specified either by its name or by its IP address. This allows you
#-# to use a remote Chrome instance, running on a separate machine, rather than a Chrome instance running in a Docker
#-# container on the same machine. Defaults to empty value, meaning that by default the PDF export is done using the
#-# Chrome instance running in the specified Docker container.
# export.pdf.chromeHost =

#-# The port number used for communicating with the headless Chrome web browser.
# export.pdf.chromeRemoteDebuggingPort = 9222

#-# [Since 14.10.15]
#-# [Since 15.5.2]
#-# [Since 15.7RC1]
#-# The base URI that the headless Chrome browser should use to access the XWiki instance (i.e. the print preview page).
#-# The host (domain or IP address) is mandatory but the scheme and port number are optional (they default on the scheme
#-# and port number used when triggering the PDF export). Defaults to "host.xwiki.internal" which means the host running
#-# the Docker daemon; if XWiki runs itself inside a Docker container then you should use the assigned network alias,
#-# provided both containers (XWiki and Chrome) are in the same Docker network.
#-#
#-# Note that this configuration replaces the old "export.pdf.xwikiHost" configuration which is currently still taken
#-# into account as a fall back in case this configuration is not set.
# export.pdf.xwikiURI = host.xwiki.internal

#-# The Docker image used to create the Docker container running the headless Chrome web browser.
# export.pdf.chromeDockerImage = zenika/alpine-chrome:latest

#-# The name of the Docker container running the headless Chrome web browser. This is especially useful when reusing an
#-# existing container.
# export.pdf.chromeDockerContainerName = headless-chrome-pdf-printer

#-# The name or id of the Docker network to add the Chrome Docker container to. This is useful when XWiki itself runs
#-# inside a Docker container and you want to have the Chrome container in the same network in order for them to
#-# communicate. The default value "bridge" represents the default Docker network.
# export.pdf.dockerNetwork = bridge

#-# [Since 14.9]
#-# The number of seconds to wait for the web page to be ready (for print) before timing out.
# export.pdf.pageReadyTimeout = 60

#-# [Since 14.10]
#-# The maximum content size, in kilobytes (KB), an user is allowed to export to PDF. In order to compute the content
#-# size we sum the size of the HTML rendering for each of the XWiki documents included in the export. The size of
#-# external resources, such as images, style sheets, JavaScript code is not taken into account. 0 means no limit.
# export.pdf.maxContentSize = 5000

#-# [Since 14.10]
#-# The maximum number of PDF exports that can be executed in parallel (each PDF export needs a separate thread).
# export.pdf.threadPoolSize = 3

#-# [Since 14.10]
#-# Whether to replace or not the old PDF export based on Apache Formatting Objects Processor (FOP).
# export.pdf.replaceFOP = true

#-------------------------------------------------------------------------------------
# Tags
#-------------------------------------------------------------------------------------

#-# [Since 14.4.8, 14.10.4, 15.0RC1]
#-# Configure the tag selection algorithm to use.
#-# The default algorithm is "exhaustive", which check all elements (documents and tags) for view right before returning
#-# them. This exhaustive check can lead to tag clouds and tag lists being slow to compute on instances with very large 
#-# amounts of tags or tagged documents (more than 5000 of elements).   
#-# Note that it is advised to keep using the default implementation as much as possible, and to switch to the "unsafe"
#-# option only when all performance improvements options have been exhausted 
#-# (see https://www.xwiki.org/xwiki/bin/view/Documentation/AdminGuide/Performances/)
#-# The "unsafe" algorithm does not perform any right checks. It is approximately 10 times faster than "exhaustive"
#-# but does not provide any guarantee that the current user won't be able to view a tag he/she is not allowed to. 
#-# Therefore, we cannot recommend to use it unless tags performance is critical AND tags and document references are 
#-# not considered as critical information.
# tag.rightCheckStrategy.hint=exhaustive
# tag.rightCheckStrategy.hint=unsafe

#-------------------------------------------------------------------------------------
# What's New
#-------------------------------------------------------------------------------------

#-# [Since 15.2RC1]
#-# Defines the list of News sources from which to get news items displayed by the What's New UI
#-# Source format:
#-#   whatsnew.sources = <a unique id> = <a valid source hint>
#-# Where:
#-#   - <a unique id>: a user-chosen id that represents the source. It's used to define the parameters for the source,
#-#     see below
#-#   - <a valid source hint>: for example use "xwikiblog" for using the XWiki Blog Application as a news source.
#-# Source parameters format:
#-#   whatsnew.source.<source id>.<key> = <value>
#-# Where:
#-#   - <source id>: this is the unique id mentioned above
#-#   - <key>: a source-dependent parameter name (e.g for the "xwikiblog" source, the "rssURL" key is used to point to
#-#     the URL that generates the RSS feed)
#-#   - <value>: a source-dependent parameter value for the specified key
#-#
#-# To disable the feature, use an empty source list, as in:
# whatsnew.sources =
#-#
#-# When not defined, the default list of sources and their configuration is:
# whatsnew.sources = xwikiorg = xwikiblog
# whatsnew.source.xwikiorg.rssURL = https://extensions.xwiki.org/news
# whatsnew.sources = xwikisas = xwikiblog
# whatsnew.sources.xwikisas.rssURL = https://xwiki.com/news

#-------------------------------------------------------------------------------------
# XML Diff
#-------------------------------------------------------------------------------------

#-# [Since 14.10.15, 15.5.1, 15.6]
#-# If the compared documents contain images, they can be embedded as data URI to compare the images themselves
#-# instead of their URLs. For this, images are downloaded via HTTP and embedded as data URI. Images are only
#-# downloaded from trusted domains when enabled above. Still, this can be a security and stability risk as
#-# downloading images can easily increase the server load. If this option is set to "false", no images are
#-# downloaded by the diff and images are compared by URL instead.
#-# Default is "true".
# diff.xml.dataURI.enabled = true

#-# [Since 14.10.15, 15.5.1, 15.6]
#-# Configure the maximum size in bytes of an image to be embedded into the XML diff output as data URI.
#-# Default is 1MB.
# diff.xml.dataURI.maximumContentSize = 1048576

#-# [Since 14.10.15, 15.5.1, 15.6]
#-# Configure the timeout in seconds for downloading an image via HTTP to embed it into the XML diff output as data URI.
#-# Default is 10 seconds.
# diff.xml.dataURI.httpTimeout = 10


