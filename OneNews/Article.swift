//
//  Article.swift
//  OneNews
//
//  Created by George Hitchman-Smith on 14/05/2025.
//
import Foundation

struct Article: Identifiable, Hashable, Equatable {
    let id = UUID()
    let title: String
    let subtitle: String
    let body: String
    let imageName: String?
    let category: String
    let date: String
}


let sampleArticles = [
    Article(title: "Microsoft Outlook’s New Email Sender Requirements", subtitle: "What You Need to Know (and Do)", body: "To all our email marketers out there, we know you’re juggling more than ever: tight KPIs, shrinking attention spans, evolving email privacy regulations… and now, stricter sender requirements from inbox providers.\n In a move to improve security and inbox quality, Microsoft Outlook has introduced new sender requirements that officially went into effect on May 5, 2025. If you're sending bulk emails, even legitimate marketing or transactional messages, this is something you need to comply with, or risk having your emails land in the spam folder or get blocked outright.", imageName: "outlook", category: "Email", date: "14th May 2025"),
    Article(title: "What Apple’s Court Ruling Means for You", subtitle: "The End of 30% Fees and What’s Next",  body: "Apple has long held the reins when it comes to how developers can monetize their apps on iOS. For developers, that typically meant submitting payments through Apple’s proprietary system, where a 30% commission fee has been the industry standard for quite some time. That business model is now facing a seismic shift, thanks to a landmark court ruling.", imageName: "apple-court", category: "iOS/Apple", date: "6th May 2025"),
    Article(title: "How Mobile Games Maximize Revenue & LTV from High Rollers", subtitle: "And how to do it yourself",  body: "Mobile gaming is a high-stakes business. While most players might casually log in for a quick round or two, it’s the VIPs, the top spenders and most loyal players, who drive a significant portion of revenue. In fact, in free-to-play games, less than 1% of users can generate over 50% of in-app purchase revenue. These are your high rollers, and keeping them engaged is critical to your game’s financial success.", imageName: "mobile-games", category: "Gaming", date: "30th April 2025"),
    Article(
    title: "OneSignal Achieves ISO 27001 and ISO 27701 Certifications",
    subtitle: "Building on SOC 2 Type 2 Compliance",
    body: "We are thrilled to announce that OneSignal has successfully obtained both ISO 27001 and ISO 27701 certifications, marking a significant milestone in our ongoing commitment to information security and privacy protection. These new certifications build upon our existing SOC 2 Type 2 compliance, further strengthening our comprehensive security framework.\nISO 27001 is the international standard for information security management. It specifies the requirements for establishing, implementing, maintaining, and continually improving an information security management system. This certification confirms that OneSignal has implemented a robust framework to protect sensitive information from unauthorized access, data breaches, and other security threats.\nISO 27701 extends ISO 27001 to include privacy information management. It provides a framework for managing privacy controls to reduce the risk to privacy rights. This certification demonstrates OneSignal's dedication to protecting personal data and compliance with privacy regulations such as GDPR.",
    imageName: "journeys-update", category: "OneSignal Updates", date: "23rd April 2025"),
    Article(
        title: "What to Know About Android Live Updates",
        subtitle: "Prep Guide for Marketers & Developers",
        body: "With the upcoming release of Android 16, Google is introducing Live Updates — persistent, real-time UI components on the lock screen or notification shade. Much like iOS Live Activities, these updates make glanceable, time-sensitive content (like food delivery, ride status, or sports scores) accessible without opening the app. For mobile marketers, this is a major opportunity. Live Updates increase brand visibility, improve user experience, and reduce churn by keeping your app top-of-mind during critical moments. With over 130 million Android users in the U.S. alone, now is the time to plan for real-time engagement. Key benefits include: - Real-time visibility on the lock screen - Better UX with glanceable updates - Cross-platform support when paired with iOS Live Activities Use cases span rideshare, food delivery, gaming, productivity, finance, and more. Developers can implement Live Updates using Jetpack Glance and updates to Foreground Services or Notifications APIs. Start preparing now by: - Auditing your app’s real-time interactions - Designing glanceable UI - Collaborating across product and marketing - Ensuring your backend supports live events With OneSignal’s existing support for iOS Live Activities and preparations for Android 16, you’ll be ready to deliver impactful, persistent updates across platforms.",
        imageName: "android-live", category: "Android", date: "4th April 2025"),
    Article(
        title: "AI vs. Human Intuition",
        subtitle: "Finding the Right Balance in Mobile Marketing",
        body: "In a world where your coffee app knows your order before you do, it’s no surprise that AI is redefining what “personalized marketing” really means. This not-so-secret sauce is setting new standards for how brands market to their customers.\nWhile AI offers incredible efficiency, it lacks the emotional depth and strategic vision that human marketers bring to the table. The real power lies in combining AI's analytical precision with human creativity and empathy to build more impactful omnichannel engagement campaigns.\nBelow, we’ll explore where AI shines, when to rely on human intuition, and how to strike the perfect balance between the two to maximize productivity and quality in your mobile marketing strategy.",
        imageName: "ai", category: "AI", date: "12th March 2025"),
    Article(
        title: "What’s New: Intelligent Journeys, Smarter Messaging",
        subtitle: "A hots of new features for a better user experience",
        body: "At OneSignal, we’re committed to helping businesses create magical, impactful customer messaging experiences with ease. We’re thrilled to announce our largest-ever release, over 25 new features and enhancements designed to make your engagement strategies smarter, more intuitive, and more effective than ever before.\nOur Spring 2025 release is all about Intelligent Engagement—using data and automation to simplify how you connect with your audience across push, email, SMS, and in-app messaging. From intelligently optimized journeys to actionable insights, these updates empower you to deliver personalized experiences that drive measurable results, all while making your workflows effortless. Ready to dive in? Let’s explore the highlights of these transformative releases.\n",
        imageName: "journeys-update", category: "OneSignal Updates", date: "1st March 2025")
]
