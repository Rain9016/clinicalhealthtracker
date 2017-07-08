//
//  QuestionnaireController.swift
//  sendLocation
//
//  Created by untitled on 12/1/17.
//  Copyright © 2017 untitled. All rights reserved.
//

import UIKit

class SurveyController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    ///////////////
    //           //
    //  SURVEYS  //
    //           //
    ///////////////
    
    var surveys = [Survey]()
    
    func setupQuestionnaires() {
        var step = Step(title: "", type: "")
        var answers = [String]()
        
        /* EQ-5D */
        
        var EQ5D = Survey(title: "EQ-5D")
        
        step = Step(title: "Mobility", type: "multiple_choice")
        answers = [String]()
        answers.append("I have no problems in walking about")
        answers.append("I have slight problems in walking about")
        answers.append("I have moderate problems in walking about")
        answers.append("I have severe problems in walking about")
        answers.append("I am unable to walk about")
        step.multiple_choice?.answers.append(contentsOf: answers)
        EQ5D.steps.append(step)
        
        step = Step(title: "Self-Care", type: "multiple_choice")
        answers = [String]()
        answers.append("I have no problems washing or dressing myself")
        answers.append("I have slight problems washing or dressing myself")
        answers.append("I have moderate problems washing or dressing myself")
        answers.append("I have severe problems washing or dressing myself")
        answers.append("I am unable to wash or dress myself")
        step.multiple_choice?.answers.append(contentsOf: answers)
        EQ5D.steps.append(step)
        
        step = Step(title: "Usual Activities", type: "multiple_choice")
        step.subtitle = "(e.g. work, study, housework, family or leisure activities)"
        answers = [String]()
        answers.append("I have no problems doing my usual activities")
        answers.append("I have slight problems doing my usual activities")
        answers.append("I have moderate problems doing my usual activities")
        answers.append("I have severe problems doing my usual activities")
        answers.append("I am unable to do my usual activities")
        step.multiple_choice?.answers.append(contentsOf: answers)
        EQ5D.steps.append(step)
        
        step = Step(title: "Pain/Discomfort", type: "multiple_choice")
        answers = [String]()
        answers.append("I have no pain or discomfort")
        answers.append("I have slight pain or discomfort")
        answers.append("I have moderate pain or discomfort")
        answers.append("I have severe pain or discomfort")
        answers.append("I have extreme pain or discomfort")
        step.multiple_choice?.answers.append(contentsOf: answers)
        EQ5D.steps.append(step)
        
        step = Step(title: "Anxiety/Depression", type: "multiple_choice")
        answers = [String]()
        answers.append("I am not anxious or depressed")
        answers.append("I am slightly anxious or depressed")
        answers.append("I am moderately anxious or depressed")
        answers.append("I am severely anxious or depressed")
        answers.append("I am extremely anxious or depressed")
        step.multiple_choice?.answers.append(contentsOf: answers)
        EQ5D.steps.append(step)
        
        step = Step(title: "We would like to know how good or bad your health is TODAY", type: "scale")
        step.subtitle = "This scale is numbered from 0 to 100. 100 means the best health you can imagine. 0 means the worst health you can imagine. Adjust the slider to indicate how your health is TODAY."
        step.scale?.min_value = 0
        step.scale?.max_value = 100
        step.scale?.default_value = 50
        step.scale?.step = 1
        EQ5D.steps.append(step)
        
        surveys.append(EQ5D)
        
        /* LSA */
        
        var LSA = Survey(title: "LSA")
        
        step = Step(title: "During the past 4 weeks, have you been to other rooms of your home besides the room where you sleep?", type: "multiple_choice")
        answers = [String]()
        answers.append("Yes")
        answers.append("No")
        step.multiple_choice?.answers.append(contentsOf: answers)
        LSA.steps.append(step)
        
        step = Step(title: "If yes, how many days within a week do you leave the room in which you sleep?", type: "multiple_choice")
        step.isSkippable = true
        answers = ["1", "2", "3", "4", "5", "6", "7"]
        step.multiple_choice?.answers.append(contentsOf: answers)
        LSA.steps.append(step)
        
        step = Step(title: "Do you need the help of another person or an assistive device in order to do this?", type: "multiple_choice")
        step.isSkippable = true
        answers = [String]()
        answers.append("Yes, assistive device")
        answers.append("Yes, another person")
        answers.append("Yes, both")
        answers.append("No")
        step.multiple_choice?.answers.append(contentsOf: answers)
        LSA.steps.append(step)
        
        step = Step(title: "During the past 4 weeks, have you been to an area outside your home such as your porch, deck or patio, hallway of an apartment building, or garage?", type: "multiple_choice")
        answers = [String]()
        answers.append("Yes")
        answers.append("No")
        step.multiple_choice?.answers.append(contentsOf: answers)
        LSA.steps.append(step)
        
        step = Step(title: "If yes, how many days within a week do you go to an area outside of your home?", type: "multiple_choice")
        step.isSkippable = true
        answers = ["1", "2", "3", "4", "5", "6", "7"]
        step.multiple_choice?.answers.append(contentsOf: answers)
        LSA.steps.append(step)
        
        step = Step(title: "Do you need the help of another person or an assistive device in order to do this?", type: "multiple_choice")
        step.isSkippable = true
        answers = [String]()
        answers.append("Yes, assistive device")
        answers.append("Yes, another person")
        answers.append("Yes, both")
        answers.append("No")
        step.multiple_choice?.answers.append(contentsOf: answers)
        LSA.steps.append(step)
        
        step = Step(title: "During the past 4 weeks, have you been to places in your neighbourhood, other than your own yard or apartment building?", type: "multiple_choice")
        answers = [String]()
        answers.append("Yes")
        answers.append("No")
        step.multiple_choice?.answers.append(contentsOf: answers)
        LSA.steps.append(step)
        
        step = Step(title: "If yes, how many days within a week do you go to places in your neighbourhood?", type: "multiple_choice")
        step.isSkippable = true
        answers = ["1", "2", "3", "4", "5", "6", "7"]
        step.multiple_choice?.answers.append(contentsOf: answers)
        LSA.steps.append(step)
        
        step = Step(title: "Do you need the help of another person or an assistive device in order to do this?", type: "multiple_choice")
        step.isSkippable = true
        answers = [String]()
        answers.append("Yes, assistive device")
        answers.append("Yes, another person")
        answers.append("Yes, both")
        answers.append("No")
        step.multiple_choice?.answers.append(contentsOf: answers)
        LSA.steps.append(step)
        
        step = Step(title: "During the past 4 weeks, have you been to places outside your neighbourhood but within your town?", type: "multiple_choice")
        answers = [String]()
        answers.append("Yes")
        answers.append("No")
        step.multiple_choice?.answers.append(contentsOf: answers)
        LSA.steps.append(step)
        
        step = Step(title: "If yes, how many days within a week do you go to places outside of your neighbourhood?", type: "multiple_choice")
        step.isSkippable = true
        answers = ["1", "2", "3", "4", "5", "6", "7"]
        step.multiple_choice?.answers.append(contentsOf: answers)
        LSA.steps.append(step)
        
        step = Step(title: "Do you need the help of another person or an assistive device in order to do this?", type: "multiple_choice")
        step.isSkippable = true
        answers = [String]()
        answers.append("Yes, assistive device")
        answers.append("Yes, another person")
        answers.append("Yes, both")
        answers.append("No")
        step.multiple_choice?.answers.append(contentsOf: answers)
        LSA.steps.append(step)
        
        step = Step(title: "During the past 4 weeks, have you been to places outside your town?", type: "multiple_choice")
        answers = [String]()
        answers.append("Yes")
        answers.append("No")
        step.multiple_choice?.answers.append(contentsOf: answers)
        LSA.steps.append(step)
        
        step = Step(title: "If yes, how many days within a week do you go to places outside of your town?", type: "multiple_choice")
        step.isSkippable = true
        answers = ["1", "2", "3", "4", "5", "6", "7"]
        step.multiple_choice?.answers.append(contentsOf: answers)
        LSA.steps.append(step)
        
        step = Step(title: "Do you need the help of another person or an assistive device in order to do this?", type: "multiple_choice")
        step.isSkippable = true
        answers = [String]()
        answers.append("Yes, assistive device")
        answers.append("Yes, another person")
        answers.append("Yes, both")
        answers.append("No")
        step.multiple_choice?.answers.append(contentsOf: answers)
        LSA.steps.append(step)
        
        step = Step(title: "Do you consider neighbourhood to be less than 1km (5-6 city blocks)?", type: "multiple_choice")
        answers = [String]()
        answers.append("Yes")
        answers.append("No")
        step.multiple_choice?.answers.append(contentsOf: answers)
        LSA.steps.append(step)
        
        step = Step(title: "Do you consider town to be less than 16km?", type: "multiple_choice")
        answers = [String]()
        answers.append("Yes")
        answers.append("No")
        step.multiple_choice?.answers.append(contentsOf: answers)
        LSA.steps.append(step)
        
        surveys.append(LSA)
        
        /* WHODAS 2.0 */
        
        var WHODAS = Survey(title: "WHODAS 2.0")
        
        step = Step(title: "Demographic and background information", type: "instruction")
        step.instruction?.content = "This interview has been developed by the World Health Organization (WHO) to better understand the difficulties people may have due to their health conditions. The information that you provide in this interview is confidential and will be used only for research. The interview will take 5-10 minutes to complete."
        WHODAS.steps.append(step)
        
        step = Step(title: "What is your current living situation?", type: "multiple_choice")
        answers = [String]()
        answers.append("Independent in community")
        answers.append("Assisted living")
        answers.append("Hospitalized")
        step.multiple_choice?.answers.append(contentsOf: answers)
        WHODAS.steps.append(step)
        
        step = Step(title: "What is your sex?", type: "multiple_choice")
        answers = [String]()
        answers.append("Male")
        answers.append("Female")
        step.multiple_choice?.answers.append(contentsOf: answers)
        WHODAS.steps.append(step)
        
        step = Step(title: "How old are you now?", type: "numeric")
        WHODAS.steps.append(step)
        
        step = Step(title: "How many years in all did you spend studying in school, college or university?", type: "numeric")
        WHODAS.steps.append(step)
        
        step = Step(title: "What is your current marital status?", type: "multiple_choice")
        answers = [String]()
        answers.append("Never married")
        answers.append("Currently married")
        answers.append("Separated")
        answers.append("Divorced")
        answers.append("Widowed")
        answers.append("Cohabiting")
        step.multiple_choice?.answers.append(contentsOf: answers)
        WHODAS.steps.append(step)
        
        step = Step(title: "Which describes your main work status best?", type: "multiple_choice")
        answers = [String]()
        answers.append("Paid work")
        answers.append("Self-employed, such as own your business or farming")
        answers.append("Non-paid work, such as volunteer or charity")
        answers.append("Student")
        answers.append("Keeping house/homemaker")
        answers.append("Retired")
        answers.append("Unemployed (health reasons)")
        answers.append("Unemployed (other reasons)")
        step.multiple_choice?.answers.append(contentsOf: answers)
        WHODAS.steps.append(step)
        
        step = Step(title: "Preamble", type: "instruction")
        step.instruction?.content = "The interview is about difficulties people have because of health conditions. By health condition I mean diseases or illnesses, or other health problems that may be short or long lasting; injuries; mental or emotional problems; and problems with alocohol or drugs."
        WHODAS.steps.append(step)
        
        step = Step(title: "Preamble", type: "instruction")
        step.instruction?.content = "Remember to keep all of your health problems in mind as you answer the questions. When I ask you about difficulties in doing an activity think about: increased effort, discomfort or pain, slowness, changes in the way you do the activity. When answering, I'd like you to think back over the past 30 days. I would also like you to answer these questions thinking about how much difficulty you have had, on average, over the past 30 days, while doing the activity as you usually do it."
        WHODAS.steps.append(step)
        
        step = Step(title: "In the past 30 days, how much difficulty did you have in standing for long periods such as 30 minutes?", type: "multiple_choice")
        answers = [String]()
        answers.append("None")
        answers.append("Mild")
        answers.append("Moderate")
        answers.append("Severe")
        answers.append("Extreme or cannot do")
        step.multiple_choice?.answers.append(contentsOf: answers)
        WHODAS.steps.append(step)
        
        step = Step(title: "In the past 30 days, how much difficulty did you have in taking care of your household responsibilities?", type: "multiple_choice")
        answers = [String]()
        answers.append("None")
        answers.append("Mild")
        answers.append("Moderate")
        answers.append("Severe")
        answers.append("Extreme or cannot do")
        step.multiple_choice?.answers.append(contentsOf: answers)
        WHODAS.steps.append(step)
        
        step = Step(title: "In the past 30 days, how much difficulty did you have in learning a new task?", type: "multiple_choice")
        step.subtitle = "e.g. learning how to get to a new place"
        answers = [String]()
        answers.append("None")
        answers.append("Mild")
        answers.append("Moderate")
        answers.append("Severe")
        answers.append("Extreme or cannot do")
        step.multiple_choice?.answers.append(contentsOf: answers)
        WHODAS.steps.append(step)
        
        step = Step(title: "In the past 30 days, how much of a problem did you have joining in community activities in the same way as everyone else can?", type: "multiple_choice")
        step.subtitle = "e.g. festivities, religious or other activities"
        answers = [String]()
        answers.append("None")
        answers.append("Mild")
        answers.append("Moderate")
        answers.append("Severe")
        answers.append("Extreme or cannot do")
        step.multiple_choice?.answers.append(contentsOf: answers)
        WHODAS.steps.append(step)
        
        step = Step(title: "In the past 30 days, how much have you been emotionally affected by your health problems?", type: "multiple_choice")
        answers = [String]()
        answers.append("None")
        answers.append("Mild")
        answers.append("Moderate")
        answers.append("Severe")
        answers.append("Extreme or cannot do")
        step.multiple_choice?.answers.append(contentsOf: answers)
        WHODAS.steps.append(step)
        
        step = Step(title: "In the past 30 days, how much difficulty did you have in concentrating on doing something for ten minutes?", type: "multiple_choice")
        answers = [String]()
        answers.append("None")
        answers.append("Mild")
        answers.append("Moderate")
        answers.append("Severe")
        answers.append("Extreme or cannot do")
        step.multiple_choice?.answers.append(contentsOf: answers)
        WHODAS.steps.append(step)
        
        step = Step(title: "In the past 30 days, how much difficulty did you have in walking a long distance such as a kilometre (or equivalent)?", type: "multiple_choice")
        answers = [String]()
        answers.append("None")
        answers.append("Mild")
        answers.append("Moderate")
        answers.append("Severe")
        answers.append("Extreme or cannot do")
        step.multiple_choice?.answers.append(contentsOf: answers)
        WHODAS.steps.append(step)
        
        step = Step(title: "In the past 30 days, how much difficulty did you have in washing your whole body?", type: "multiple_choice")
        answers = [String]()
        answers.append("None")
        answers.append("Mild")
        answers.append("Moderate")
        answers.append("Severe")
        answers.append("Extreme or cannot do")
        step.multiple_choice?.answers.append(contentsOf: answers)
        WHODAS.steps.append(step)
        
        step = Step(title: "In the past 30 days, how much difficulty did you have in getting dressed?", type: "multiple_choice")
        answers = [String]()
        answers.append("None")
        answers.append("Mild")
        answers.append("Moderate")
        answers.append("Severe")
        answers.append("Extreme or cannot do")
        step.multiple_choice?.answers.append(contentsOf: answers)
        WHODAS.steps.append(step)
        
        step = Step(title: "In the past 30 days, how much difficulty did you have in dealing with people you do not know?", type: "multiple_choice")
        answers = [String]()
        answers.append("None")
        answers.append("Mild")
        answers.append("Moderate")
        answers.append("Severe")
        answers.append("Extreme or cannot do")
        step.multiple_choice?.answers.append(contentsOf: answers)
        WHODAS.steps.append(step)
        
        step = Step(title: "In the past 30 days, how much difficulty did you have in maintaining a friendship?", type: "multiple_choice")
        answers = [String]()
        answers.append("None")
        answers.append("Mild")
        answers.append("Moderate")
        answers.append("Severe")
        answers.append("Extreme or cannot do")
        step.multiple_choice?.answers.append(contentsOf: answers)
        WHODAS.steps.append(step)
        
        step = Step(title: "In the past 30 days, how much difficulty did you have in your day-to-day work or school?", type: "multiple_choice")
        answers = [String]()
        answers.append("None")
        answers.append("Mild")
        answers.append("Moderate")
        answers.append("Severe")
        answers.append("Extreme or cannot do")
        step.multiple_choice?.answers.append(contentsOf: answers)
        WHODAS.steps.append(step)
        
        step = Step(title: "Overall, in the past 30 days, how many days were these difficulties present?", type: "numeric")
        WHODAS.steps.append(step)
        
        step = Step(title: "In the past 30 days, for how many days were you totally unable to carry out your usual activities or work because of any health condition?", type: "numeric")
        WHODAS.steps.append(step)
        
        step = Step(title: "In the past 30 days, not counting the days that you were totally unable, for how many days did you cut back or reduce your usual activities or work because of any health condition?", type: "numeric")
        WHODAS.steps.append(step)
        
        surveys.append(WHODAS)
        
        /* Adelaide Activities Profile */
        
        var adelaideActivitiesProfile = Survey(title: "Adelaide Activities Profile")
        
        step = Step(title: "How often have you prepared a main meal?", type: "multiple_choice")
        answers = [String]()
        answers.append("Never")
        answers.append("Less than once a week")
        answers.append("1-2 times a week")
        answers.append("Most days")
        step.multiple_choice?.answers.append(contentsOf: answers)
        adelaideActivitiesProfile.steps.append(step)
        
        step = Step(title: "How often have you washed the dishes?", type: "multiple_choice")
        answers = [String]()
        answers.append("Less than once a week")
        answers.append("1-2 days a week")
        answers.append("Most days")
        answers.append("Every day")
        step.multiple_choice?.answers.append(contentsOf: answers)
        adelaideActivitiesProfile.steps.append(step)
        
        step = Step(title: "How often have you washed the clothes?", type: "multiple_choice")
        answers = [String]()
        answers.append("Never")
        answers.append("About once a month")
        answers.append("About once a fortnight")
        answers.append("Once a week or more")
        step.multiple_choice?.answers.append(contentsOf: answers)
        adelaideActivitiesProfile.steps.append(step)
        
        step = Step(title: "How often have you done light house work?", type: "multiple_choice")
        answers = [String]()
        answers.append("Never")
        answers.append("Once a fortnight or less")
        answers.append("About once a week")
        answers.append("Several days a week")
        step.multiple_choice?.answers.append(contentsOf: answers)
        adelaideActivitiesProfile.steps.append(step)
        
        step = Step(title: "How often have you done heavy house work?", type: "multiple_choice")
        answers = [String]()
        answers.append("Never")
        answers.append("About once a month")
        answers.append("About once a fortnight")
        answers.append("Once a week or more")
        step.multiple_choice?.answers.append(contentsOf: answers)
        adelaideActivitiesProfile.steps.append(step)
        
        step = Step(title: "How many hours of voluntary or paid employment have you done?", type: "multiple_choice")
        answers = [String]()
        answers.append("None")
        answers.append("Up to 10 hours/week")
        answers.append("10-30 hours/week")
        answers.append("More than 30 hrs/week")
        step.multiple_choice?.answers.append(contentsOf: answers)
        adelaideActivitiesProfile.steps.append(step)
        
        step = Step(title: "How often have you cared for other family members?", type: "multiple_choice")
        answers = [String]()
        answers.append("Never")
        answers.append("About once a month")
        answers.append("About once a fortnight")
        answers.append("Once a week or more")
        step.multiple_choice?.answers.append(contentsOf: answers)
        adelaideActivitiesProfile.steps.append(step)
        
        step = Step(title: "How often have you done household shopping?", type: "multiple_choice")
        answers = [String]()
        answers.append("Never")
        answers.append("About once a month")
        answers.append("About once a fortnight")
        answers.append("Once a week or more")
        step.multiple_choice?.answers.append(contentsOf: answers)
        adelaideActivitiesProfile.steps.append(step)
        
        step = Step(title: "How often have you done personal shopping?", type: "multiple_choice")
        answers = [String]()
        answers.append("Never")
        answers.append("Once in three months")
        answers.append("About once a month")
        answers.append("Once a fortnight or more")
        step.multiple_choice?.answers.append(contentsOf: answers)
        adelaideActivitiesProfile.steps.append(step)
        
        step = Step(title: "How often have you done light gardening?", type: "multiple_choice")
        answers = [String]()
        answers.append("Never")
        answers.append("About once a month")
        answers.append("About once a fortnight")
        answers.append("Once a week or more")
        step.multiple_choice?.answers.append(contentsOf: answers)
        adelaideActivitiesProfile.steps.append(step)
        
        step = Step(title: "How often have you done heavy gardening?", type: "multiple_choice")
        answers = [String]()
        answers.append("Never")
        answers.append("About once a month")
        answers.append("About once a fortnight")
        answers.append("Once a week or more")
        step.multiple_choice?.answers.append(contentsOf: answers)
        adelaideActivitiesProfile.steps.append(step)
        
        step = Step(title: "How often have you done household and/or car maintenance?", type: "multiple_choice")
        answers = [String]()
        answers.append("Never")
        answers.append("Once in three months")
        answers.append("About once a month")
        answers.append("Once a fortnight or more")
        step.multiple_choice?.answers.append(contentsOf: answers)
        adelaideActivitiesProfile.steps.append(step)
        
        step = Step(title: "How often have you needed to drive a car or organise your own transport?", type: "multiple_choice")
        answers = [String]()
        answers.append("Never")
        answers.append("Up to once a month")
        answers.append("Up to once a fortnight")
        answers.append("Once a week or more")
        step.multiple_choice?.answers.append(contentsOf: answers)
        adelaideActivitiesProfile.steps.append(step)
        
        step = Step(title: "How often have you spent some time on a hobby?", type: "multiple_choice")
        answers = [String]()
        answers.append("Never")
        answers.append("About once a month")
        answers.append("About once a fortnight")
        answers.append("More than once a week")
        step.multiple_choice?.answers.append(contentsOf: answers)
        adelaideActivitiesProfile.steps.append(step)
        
        step = Step(title: "How many telephone calls have you made to friends or family?", type: "multiple_choice")
        answers = [String]()
        answers.append("Never")
        answers.append("Up to three calls/week")
        answers.append("4-10 calls/week")
        answers.append("Over 10 calls/week")
        step.multiple_choice?.answers.append(contentsOf: answers)
        adelaideActivitiesProfile.steps.append(step)
        
        step = Step(title: "How often have you invited people to your home?", type: "multiple_choice")
        answers = [String]()
        answers.append("Less than once/fortnight")
        answers.append("About once a fortnight")
        answers.append("About once a week")
        answers.append("More than once a week")
        step.multiple_choice?.answers.append(contentsOf: answers)
        adelaideActivitiesProfile.steps.append(step)
        
        step = Step(title: "How often have you participated in social activities at a centre such as a club, a church or a community centre?", type: "multiple_choice")
        answers = [String]()
        answers.append("Less than once/month")
        answers.append("About once a month")
        answers.append("About once a fortnight")
        answers.append("Once a week or more")
        step.multiple_choice?.answers.append(contentsOf: answers)
        adelaideActivitiesProfile.steps.append(step)
        
        step = Step(title: "How often have you attended religious services or meetings?", type: "multiple_choice")
        answers = [String]()
        answers.append("Never")
        answers.append("About once a month")
        answers.append("About once a fortnight")
        answers.append("Once a week or more")
        step.multiple_choice?.answers.append(contentsOf: answers)
        adelaideActivitiesProfile.steps.append(step)
        
        step = Step(title: "How often have you participated in an outdoor social activity?", type: "multiple_choice")
        answers = [String]()
        answers.append("Never")
        answers.append("About once a month")
        answers.append("About once a fortnight")
        answers.append("Once a week or more")
        step.multiple_choice?.answers.append(contentsOf: answers)
        adelaideActivitiesProfile.steps.append(step)
        
        step = Step(title: "How often have you spent some time outdoor participating in a recreational or sporting activity?", type: "multiple_choice")
        answers = [String]()
        answers.append("Never")
        answers.append("About once a month")
        answers.append("About once a week")
        answers.append("More than once a week")
        step.multiple_choice?.answers.append(contentsOf: answers)
        adelaideActivitiesProfile.steps.append(step)
        
        step = Step(title: "How often have you spent some time outdoor participating in a recreational or sporting activity?", type: "multiple_choice")
        answers = [String]()
        answers.append("Once/month or less")
        answers.append("About once a fortnight")
        answers.append("About once a week")
        answers.append("Most days")
        step.multiple_choice?.answers.append(contentsOf: answers)
        adelaideActivitiesProfile.steps.append(step)
        
        surveys.append(adelaideActivitiesProfile)
    }
    
    
    /////////////////////////
    //                     //
    //  SCROLL VIEW STUFF  //
    //                     //
    /////////////////////////
    
    let scrollView = UIScrollView()
    
    func setupScrollView() {
        scrollView.frame = view.bounds
    }
    
    func constrainScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: topLayoutGuide.topAnchor).isActive = true /* attach the top of the scrollview to below the navigation bar */
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: bottomLayoutGuide.bottomAnchor).isActive = true /* attach the bottom of the scrollview to above the tab bar */
    }
    
    ////////////////////////
    //                    //
    //  TABLE VIEW STUFF  //
    //                    //
    ////////////////////////
    
    var selectedSurvey = 0
    let tableView = UITableView()
    
    func setupTableView() {
        tableView.frame = view.bounds /* this is needed for tableView.layoutIfNeeded() to work, I'm not sure why */
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.isScrollEnabled = false
        
        /* calculate and set tableview height */
        tableView.layoutIfNeeded()
        tableView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: tableView.contentSize.height)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return surveys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = surveys[indexPath.row].title
        cell.textLabel?.numberOfLines = 0;
        cell.textLabel?.lineBreakMode = .byWordWrapping
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedSurvey = indexPath.row
        beginButton.isEnabled = true
        beginButton.alpha = 1
    }
    
    ////////////////////
    //                //
    //  BUTTON STUFF  //
    //                //
    ////////////////////
    
    let beginButton = UIButton()
    
    func setupBeginButton() {
        beginButton.frame = CGRect(x: view.frame.size.width/3, y: tableView.contentSize.height + 20, width: view.frame.size.width/3, height: 40)
        
        beginButton.backgroundColor = UIColor.white
        beginButton.setTitleColor(UIColor.init(r: 204, g: 0, b: 0), for: .normal)
        beginButton.setTitle("Begin", for: .normal)
        beginButton.layer.borderWidth = 1
        beginButton.layer.borderColor = UIColor.init(r: 204, g: 0, b: 0).cgColor
        beginButton.layer.cornerRadius = 4
        
        beginButton.addTarget(self, action: #selector(handleBeginButton), for: .touchUpInside)
        
        beginButton.isEnabled = false
        beginButton.alpha = 0.2
    }
    
    func handleBeginButton() {
        let survey = surveys[selectedSurvey]
        
        guard survey.steps.count > 0 else {
            //print("Questionnaire contains no steps")
            return
        }
        
        let currentStep = 0
        
        if (survey.steps[currentStep].type == "instruction") {
            let instructionController = InstructionController()
            instructionController.survey = survey
            instructionController.currentStep = currentStep
            instructionController.answers = [[String:String]]()
            
            beginButton.isEnabled = false
            beginButton.alpha = 0.5;
            
            let newNavigationController = UINavigationController(rootViewController: instructionController)
            present(newNavigationController, animated: true, completion: nil)
        } else if (survey.steps[currentStep].type == "multiple_choice") {
            let multipleChoiceController = MultipleChoiceController()
            multipleChoiceController.survey = survey
            multipleChoiceController.currentStep = currentStep
            multipleChoiceController.answers = [[String:String]]()
            
            beginButton.isEnabled = false
            beginButton.alpha = 0.5
            
            let newNavigationController = UINavigationController(rootViewController: multipleChoiceController)
            present(newNavigationController, animated: true, completion: nil)
        } else if (survey.steps[currentStep].type == "text_field" || survey.steps[currentStep].type == "numeric") {
            let textFieldController = TextFieldController()
            textFieldController.survey = survey
            textFieldController.currentStep = currentStep
            textFieldController.answers = [[String:String]]()
            
            beginButton.isEnabled = false
            beginButton.alpha = 0.5
            
            let newNavigationController = UINavigationController(rootViewController: textFieldController)
            present(newNavigationController, animated: true, completion: nil)
        } else if (survey.steps[currentStep].type == "scale") {
            let scaleController = ScaleController()
            scaleController.survey = survey
            scaleController.currentStep = currentStep
            scaleController.answers = [[String:String]]()
            
            beginButton.isEnabled = false
            beginButton.alpha = 0.5;
            
            let newNavigationController = UINavigationController(rootViewController: scaleController)
            present(newNavigationController, animated: true, completion: nil)
        }
    }
    
    ////////////////////
    //                //
    //  MAIN PROGRAM  //
    //                //
    ////////////////////
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        self.navigationItem.title = "Surveys"
        
        setupQuestionnaires()
        
        setupScrollView()
        view.addSubview(scrollView)
        constrainScrollView()
        
        setupTableView()
        scrollView.addSubview(tableView)
        
        setupBeginButton()
        scrollView.addSubview(beginButton)
        
        ///////////////////////////////////
        //                               //
        //  SET SCROLLVIEW CONTENT SIZE  //
        //                               //
        ///////////////////////////////////
        
        let scrollViewHeight = tableView.contentSize.height + 70
        scrollView.contentSize = CGSize(width: view.frame.width, height: CGFloat(scrollViewHeight))
    }
}
