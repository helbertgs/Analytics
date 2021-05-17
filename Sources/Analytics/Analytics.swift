#if canImport(UIKit)
import UIKit

/// Reference:
/// v1: https://developers.google.com/analytics/devguides/collection/protocol/v1/reference
/// v4: https://ga-dev-tools.appspot.com/hit-builder/
public final class Analytics {

    // MARK: - Private Property(ies).

    private var params: [String: Any]

    // MARK: - Constructor(s).

    public init() {
        params = [:]
    }

    // MARK: - General.

    public func request(method: Method = .get, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        URLSession.shared.dataTask(with: Request.factory(method: method, params: params), completionHandler: completionHandler)
    }

    /// Show the parameters.
    @discardableResult
    public func debug(with method: Method = .get) -> Self {
        dump(Request.factory(method: method, params: params))
        return self
    }

    /// The Protocol version. The current value is '1'. This will only change when there are changes made that are not backwards compatible. (Required)
    /// - Parameter v: The protocol version.
    @discardableResult
    public func set(v value: Version) -> Self {
        params["v"] = value.rawValue
        return self
    }
    /// The tracking ID / web property ID. The format is UA-XXXX-Y. All collected data is associated by this ID. (Required)
    /// - Parameter tid: Tracking ID/ Web Property ID.
    @discardableResult
    public func set(tid value: String) -> Self {
        params["tid"] = value
        return self
    }

    /// When present, the IP address of the sender will be anonymized. For example, the IP will be anonymized if any of the following parameters are present in the payload: &aip=, &aip=0, or &aip=1. (Optional)
    /// - Parameter aip: Anonymize IP.
    @discardableResult
    public func set(aip value: Bool) -> Self {
        params["aip"] = value ? 1 : 0
        return self
    }

    /// Use this parameter to mark an event as disabled for advertising personalization, including for events from a property with a setting that otherwise permits ads personalization. For example, if a transaction is marked to disable advertising personalization, it won't be used when populating a remarketing audience for "past purchasers". (Optional)
    /// - Parameter npa: Disabling Advertising Personalization.
    @discardableResult
    public func set(npa value: Bool) -> Self {
        params["npa"] = value ? 1 : 0
        return self
    }

    /// Indicates the data source of the hit. Hits sent from analytics.js will have data source set to 'web'; hits sent from one of the mobile SDKs will have data source set to 'app'. (Optional)
    /// - Parameter ds: Data Source.
    @discardableResult
    public func set(ds value: String) -> Self {
        params["ds"] = value
        return self
    }

    /// Used to collect offline / latent hits. The value represents the time delta (in milliseconds) between when the hit being reported occurred and the time the hit was sent. The value must be greater than or equal to 0. Values greater than four hours may lead to hits not being processed. (Optional)
    /// - Parameter qt: Queue Time.
    @discardableResult
    public func set(qt value: Int) -> Self {
        params["qt"] = value
        return self
    }

    /// Used to send a random number in GET requests to ensure browsers and proxies don't cache hits. It should be sent as the final parameter of the request since we've seen some 3rd party internet filtering software add additional parameters to HTTP requests incorrectly. This value is not used in reporting. (Optional)
    /// - Parameter z: Cache Buster.
    @discardableResult
    public func set(z value: String) -> Self {
        params["z"] = value
        return self
    }

    // MARK: - User.

    /// This field is required if User ID (uid) is not specified in the request. This pseudonymously identifies a particular user, device, or browser instance. For the web, this is generally stored as a first-party cookie with a two-year expiration. For mobile apps, this is randomly generated for each particular instance of an application install. The value of this field should be a random UUID (version 4) as described in http://www.ietf.org/rfc/rfc4122.txt. (Optional)
    /// - Parameter cid: Client ID
    @discardableResult
    public func set(cid value: UUID) -> Self {
        params["cid"] = value.uuidString
        return self
    }

    /// This field is required if Client ID (cid) is not specified in the request. This is intended to be a known identifier for a user provided by the site owner/library user. It must not itself be PII (personally identifiable information). The value should never be persisted in Google Analytics cookies or other Analytics provided storage.  (Optional).
    /// - Parameter uid: User ID.
    @discardableResult
    public func set(uid value: String) -> Self {
        params["uid"] = value
        return self
    }

    // MARK: - Session.

    /// Used to control the session duration. A value of 'start' forces a new session to start with this hit and 'end' forces the current session to end with this hit. All other values are ignored. (Optional).
    /// - Parameter sc: Session Control.
    @discardableResult
    public func set(sc value: String) -> Self {
        params["sc"] = value
        return self
    }

    /// The IP address of the user. This should be a valid IP address in IPv4 or IPv6 format. It will always be anonymized just as though &aip (anonymize IP) had been used. (Optional).
    /// - Parameter uip: IP Override.
    @discardableResult
    public func set(uip value: String) -> Self {
        params["uip"] = value
        return self
    }

    /// The User Agent of the browser. Note that Google has libraries to identify real user agents. Hand crafting your own agent could break at any time. (Optional)
    /// Example value: `Opera/9.80 (Windows NT 6.0) Presto/2.12.388 Version/12.14`
    /// - Parameter ua: User Agent Override.
    @discardableResult
    public func set(ua value: UserAgent) -> Self {
        params["ua"] = value.value
        return self
    }

    /// The geographical location of the user. The geographical ID should be a two letter country code or a criteria ID representing a city or region (see http://developers.google.com/analytics/devguides/collection/protocol/v1/geoid). This parameter takes precedent over any location derived from IP address, including the IP Override parameter. An invalid code will result in geographical dimensions to be set to '(not set)'. (Optional)
    /// Example value: `US`
    /// Example value: `21137`
    /// - Parameter geoid: Geographical Override.
    @discardableResult
    public func set(geoid value: String) -> Self {
        params["geoid"] = value
        return self
    }

    // MARK: - Traffic Sources.

    /// Specifies which referral source brought traffic to a website. This value is also used to compute the traffic source. The format of this value is a URL. (Optional)
    /// Example value: http://example.com
    /// - Parameter dr: Document Referrer.
    @discardableResult
    public func set(dr value: String) -> Self {
        params["dr"] = value
        return self
    }

    /// Specifies the campaign name. (Optional)
    /// Example value: (direct).
    /// - Parameter cn: Campaign Name.
    @discardableResult
    public func set(cn value: String) -> Self {
        params["cn"] = value
        return self
    }

    /// Specifies the campaign medium. (Optional).
    /// Example value: organic
    /// - Parameter cm: Campaign Medium.
    @discardableResult
    public func set(cm value: String) -> Self {
        params["cm"] = value
        return self
    }

    /// Specifies the campaign keyword. (Optional)
    /// Example value: Blue Shoes.
    /// - Parameter ck: Campaign Keyword.
    @discardableResult
    public func set(ck value: String) -> Self {
        params["ck"] = value
        return self
    }

    /// Specifies the campaign content. (Optional).
    /// Example value: content
    /// - Parameter cc: Campaign Content
    @discardableResult
    public func set(cc value: String) -> Self {
        params["cc"] = value
        return self
    }

    /// Specifies the campaign ID. (Optional).
    /// - Parameter ci: Campaign ID
    @discardableResult
    public func set(ci value: String) -> Self {
        params["ci"] = value
        return self
    }

    /// Specifies the Google Ad Id. (Optional).
    /// Example value: CL6Q-OXyqKUCFcgK2goddQuoHg
    /// - Parameter gclid: Google Ads ID.
    @discardableResult
    public func set(gclid value: String) -> Self {
        params["gclid"] = value
        return self
    }

    /// Specifies the Google Display Ads Id. (Optional).
    /// Example value: d_click_id.
    /// - Parameter dclid: Google Display Ads ID
    @discardableResult
    public func set(dclid value: String) -> Self {
        params["dclid"] = value
        return self
    }

    // MARK: - System Info.

    /// Specifies the screen resolution. (Optional).
    /// Example value: 800x600
    /// - Parameter sr: Screen Resolution
    @discardableResult
    public func set(sr value: String) -> Self {
        params["sr"] = value
        return self
    }

    /// Specifies the viewable area of the browser / device. (Optional)
    /// Example value: 123x456
    /// - Parameter vp: Viewport size
    @discardableResult
    public func set(vp value: String) -> Self {
        params["vp"] = value
        return self
    }

    /// Specifies the character set used to encode the page / document. (Optional)
    /// Example value: UTF-8
    /// - Parameter de: Document Encoding
    @discardableResult
    public func set(de value: String) -> Self {
        params["de"] = value
        return self
    }

    /// Specifies the screen color depth. (Optional).
    /// Example value: 24-bits
    /// - Parameter sd: Screen Colors
    @discardableResult
    public func set(sd value: String) -> Self {
        params["sd"] = value
        return self
    }

    /// Specifies the language.
    /// Example value: en-us
    /// - Parameter ul:
    @discardableResult
    public func set(ul value: String) -> Self {
        params["ul"] = value
        return self
    }

    /// Specifies whether Java was enabled.
    /// Example value: 1
    /// - Parameter je:
    @discardableResult
    public func set(je value: Bool) -> Self {
        params["je"] = value ? 1 : 0
        return self
    }

    /// Specifies the flash version.
    /// Example value: 10 1 r103
    /// - Parameter fl:
    @discardableResult
    public func set(fl value: String) -> Self {
        params["fl"] = value
        return self
    }

    // MARK: - Hit.

    /// The type of hit. Must be one of 'pageview', 'screenview', 'event', 'transaction', 'item', 'social', 'exception', 'timing'. (Required)
    /// Example value: pageview
    /// - Parameter t: Hit type
    @discardableResult
    public func set(t value: String) -> Self {
        params["t"] = value
        return self
    }

    /// Specifies that a hit be considered non-interactive. (Optional)
    /// - Parameter ni: Non-Interaction Hit.
    @discardableResult
    public func set(ni value: Bool) -> Self {
        params["ni"] = value ? 1 : 0
        return self
    }

    // MARK: - Content Information.

    /// Use this parameter to send the full URL (document location) of the page on which content resides. You can use the &dh and &dp parameters to override the hostname and path + query portions of the document location, accordingly. The JavaScript clients determine this parameter using the concatenation of the document.location.origin + document.location.pathname + document.location.search browser parameters. Be sure to remove any user authentication or other private information from the URL if present. For 'pageview' hits, either &dl or both &dh and &dp have to be specified for the hit to be valid. (Optional)
    /// Example value: http://foo.com/home?a=b
    /// - Parameter dl: Document location URL.
    @discardableResult
    public func set(dl value: String) -> Self {
        params["dl"] = value
        return self
    }

    /// Specifies the hostname from which content was hosted. (Optional)
    /// Expected value: foo.com
    /// - Parameter dh: Document Host Name
    @discardableResult
    public func set(dh value: String) -> Self {
        params["dh"] = value
        return self
    }

    /// The path portion of the page URL. Should begin with '/'. For 'pageview' hits, either &dl or both &dh and &dp have to be specified for the hit to be valid. (Optional)
    /// Expected value: /foo
    /// - Parameter dp: Document Path
    @discardableResult
    public func set(dp value: String) -> Self {
        params["dp"] = value
        return self
    }

    /// The title of the page / document. (Optional)
    /// Expected value: Settings
    /// - Parameter dt: Document Title
    @discardableResult
    public func set(dt value: String) -> Self {
        params["dt"] = value
        return self
    }

    /// This parameter is optional on web properties, and required on mobile properties for screenview hits, where it is used for the 'Screen Name' of the screenview hit. On web properties this will default to the unique URL of the page by either using the &dl parameter as-is or assembling it from &dh and &dp. (Required).
    /// Expected value: High Scores
    /// - Parameter cd: Screen Name.
    @discardableResult
    public func set(cd value: String) -> Self {
        params["cd"] = value
        return self
    }

    /// You can have up to 5 content groupings, each of which has an associated index between 1 and 5, inclusive. Each content grouping can have up to 100 content groups. The value of a content group is hierarchical text delimited by '/". All leading and trailing slashes will be removed and any repeated slashes will be reduced to a single slash. For example, '/a//b/' will be converted to 'a/b'. (Optional)
    /// Expected value: news/sports
    /// - Parameter cg: Content Group
    @discardableResult
    public func set(cg value: String) -> Self {
        params["cg"] = value
        return self
    }

    /// The ID of a clicked DOM element, used to disambiguate multiple links to the same URL in In-Page Analytics reports when Enhanced Link Attribution is enabled for the property. (Optional).
    /// Expected value: nav_bar
    /// - Parameter linkid: Link ID
    @discardableResult
    public func set(linkid value: String) -> Self {
        params["linkid"] = value
        return self
    }

    // MARK: - Apps.

    /// Specifies the application name. This field is required for any hit that has app related data (i.e., app version, app ID, or app installer ID). For hits sent to web properties, this field is optional. (Optional)
    /// Example value: My App
    /// - Parameter an: Application Name.
    @discardableResult
    public func set(an value: String) -> Self {
        params["an"] = value
        return self
    }

    /// Application identifier (Optional)
    /// Example value: com.company.app
    /// - Parameter aid: Bundle identifier.
    @discardableResult
    public func set(aid value: String) -> Self {
        params["aid"] = value
        return self
    }

    /// Specifies the application version. (Optional)
    /// Example value: 0.1.0
    /// - Parameter av: Appllication Version.
    @discardableResult
    public func set(av value: String) -> Self {
        params["av"] = value
        return self
    }

    /// Application installer identifier. (Optional)
    /// Example value: com.platform.vending
    /// - Parameter aiid: Application installer Id
    @discardableResult
    public func set(aiid value: String) -> Self {
        params["aiid"] = value
        return self
    }

    // MARK: - Events

    /// Specifies the event category. Must not be empty. (Required)
    /// Example Value: Category.
    /// - Parameter ec: Event Category
    @discardableResult
    public func set(ec value: String) -> Self {
        params["ec"] = value
        return self
    }

    /// Specifies the event action. Must not be empty. (Required)
    /// Example Value: Action.
    /// - Parameter ea: Event Action
    @discardableResult
    public func set(ea value: String) -> Self {
        params["ea"] = value
        return self
    }

    /// Specifies the event label.
    /// Example Value: Label.
    /// - Parameter el: Event Label
    @discardableResult
    public func set(el value: String) -> Self {
        params["el"] = value
        return self
    }

    /// Specifies the event value. Must not be non-negative
    /// Example Value: 55.
    /// - Parameter ev: Event Value
    @discardableResult
    public func set(ev value: Int) -> Self {
        params["ev"] = value
        return self
    }

    // MARK: - Social Interactions.

    /// Specifies the social network, for example Facebook or Google Plus. (Required)
    /// Example Value: facebook.
    /// - Parameter sn: Social Network.
    @discardableResult
    public func set(sn value: String) -> Self {
        params["sn"] = value
        return self
    }

    /// Specifies the social interaction action. For example on Google Plus when a user clicks the +1 button, the social action is 'plus'. (Required)
    /// Example Value: like.
    /// - Parameter sa: Social Action.
    @discardableResult
    public func set(sa value: String) -> Self {
        params["sa"] = value
        return self
    }

    /// Specifies the target of a social interaction. This value is typically a URL but can be any text. (Required)
    /// Example value: http://foo.com
    /// - Parameter st: Social Action Target.
    @discardableResult
    public func set(st value: String) -> Self {
        params["st"] = value
        return self
    }

    // MARK: - Exceptions.

    /// Specifies the description of an exception. (Optional)
    /// Example value: DatabaseError
    /// - Parameter exd:Exception Description.
    @discardableResult
    public func set(exd value: String) -> Self {
        params["exd"] = value
        return self
    }

    /// Specifies whether the exception was fatal. (Optional)
    /// Example value: true
    /// - Parameter exf: Is Exception Fatal?
    @discardableResult
    public func set(exf value: Bool) -> Self {
        params["exf"] = value ? 1 : 0
        return self
    }

    // MARK: - Custom Dimensions / Metrics.

    /// Each custom dimension has an associated index. There is a maximum of 20 custom dimensions (200 for Analytics 360 accounts). The dimension index must be a positive integer between 1 and 200, inclusive. (Optional)
    /// - Parameter cd: Custom Dimension Index.
    /// - Parameter value: Custom Dimension Value.
    @discardableResult
    public func set(cd index: Int, value: String) -> Self {
        params["cd\(index)"] = value
        return self
    }

    /// Each custom metric has an associated index. There is a maximum of 20 custom metrics (200 for Analytics 360 accounts). The metric index must be a positive integer between 1 and 200, inclusive.. (Optional)
    /// - Parameter cm: Custom Metric Index.
    /// - Parameter value: Custom Metric Value.
    @discardableResult
    public func set(cm index: Int, value: Int) -> Self {
        params["cm\(index)"] = value
        return self
    }
}

#endif
