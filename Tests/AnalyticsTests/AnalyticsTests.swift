import Nimble
import Quick
import XCTest
@testable import Analytics

final class AnalyticsTests: QuickSpec {
    override func spec() {
        describe("Analytics") {
            context("") {
                it("") {
                    Analytics()
                        .set(v: .v1)
                        .set(tid: "UA-XXXX-Y")
                        .set(t: "event")
                        .debug(with: .get)
                        .request() { (_, _, error) in
                            if let error = error {
                                print(error.localizedDescription)
                            }
                        }
                }
            }
        }
    }

    static var allTests = [
        ("spec", spec),
    ]
}
