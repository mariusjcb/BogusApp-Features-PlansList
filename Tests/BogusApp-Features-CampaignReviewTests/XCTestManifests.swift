import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(BogusApp_Features_CampaignReviewTests.allTests),
    ]
}
#endif
