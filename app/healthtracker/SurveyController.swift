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
        
        /* Hospital Anxiety and Depression Scale (HADS) */
        
        var HADS = Survey(title: "HADS")
        
        step = Step(title: "Preamble", type: "instruction")
        step.instruction?.content = "Select the reply that is closest to how you have been feeling in the past week. Don’t take too long over you replies: your immediate is best"
        HADS.steps.append(step)
        
        step = Step(title: "I feel tense or 'wound up'", type: "multiple_choice")
        answers = [String]()
        answers.append("Most of the time")
        answers.append("A lot of the time")
        answers.append("From time to time, occasionally")
        answers.append("Not at all")
        step.multiple_choice?.answers.append(contentsOf: answers)
        HADS.steps.append(step)
        
        step = Step(title: "I feel as if I am slowed down", type: "multiple_choice")
        answers = [String]()
        answers.append("Nearly all the time")
        answers.append("Very often")
        answers.append("Sometimes")
        answers.append("Not at all")
        step.multiple_choice?.answers.append(contentsOf: answers)
        HADS.steps.append(step)
        
        step = Step(title: "I still enjoy the things I used to enjoy", type: "multiple_choice")
        answers = [String]()
        answers.append("Definitely as much")
        answers.append("Not quite so much")
        answers.append("Only a little")
        answers.append("Hardly at all")
        step.multiple_choice?.answers.append(contentsOf: answers)
        HADS.steps.append(step)
        
        step = Step(title: "I get a sort of frightened feeling like 'butterflies' in the stomach", type: "multiple_choice")
        answers = [String]()
        answers.append("Not at all")
        answers.append("Occasionally")
        answers.append("Quite often")
        answers.append("Very Often")
        step.multiple_choice?.answers.append(contentsOf: answers)
        HADS.steps.append(step)
        
        step = Step(title: "I get a sort of frightened feeling as if something awful is about to happen", type: "multiple_choice")
        answers = [String]()
        answers.append("Very definitely and quite badly")
        answers.append("Yes, but not too badly")
        answers.append("A little, but it doesn't worry me")
        answers.append("Not at all")
        step.multiple_choice?.answers.append(contentsOf: answers)
        HADS.steps.append(step)
        
        step = Step(title: "I have lost interest in my appearance", type: "multiple_choice")
        answers = [String]()
        answers.append("Definitely")
        answers.append("I don't take as much care as I should")
        answers.append("I may not take quite as much care")
        answers.append("I take just as much care as ever ")
        step.multiple_choice?.answers.append(contentsOf: answers)
        HADS.steps.append(step)
        
        step = Step(title: "I can laugh and see the funny side of things", type: "multiple_choice")
        answers = [String]()
        answers.append("As much as I always could")
        answers.append("Not quite so much now")
        answers.append("Definitely not so much now")
        answers.append("Not at all")
        step.multiple_choice?.answers.append(contentsOf: answers)
        HADS.steps.append(step)
        
        step = Step(title: "I feel restless as I have to be on the move", type: "multiple_choice")
        answers = [String]()
        answers.append("Very much indeed")
        answers.append("Quite a lot")
        answers.append("Not very much")
        answers.append("Not at all")
        step.multiple_choice?.answers.append(contentsOf: answers)
        HADS.steps.append(step)
        
        step = Step(title: "Worrying thoughts go through my mind", type: "multiple_choice")
        answers = [String]()
        answers.append("A great deal of the time")
        answers.append("A lot of the time")
        answers.append("From time to time, but not too often")
        answers.append("Only occasionally")
        step.multiple_choice?.answers.append(contentsOf: answers)
        HADS.steps.append(step)
        
        step = Step(title: "I look forward with enjoyment to things", type: "multiple_choice")
        answers = [String]()
        answers.append("As much as I ever did")
        answers.append("Rather less than I used to")
        answers.append("Definitely less than I used to")
        answers.append("Hardly at all")
        step.multiple_choice?.answers.append(contentsOf: answers)
        HADS.steps.append(step)
        
        step = Step(title: "I feel cheerful", type: "multiple_choice")
        answers = [String]()
        answers.append("Not at all")
        answers.append("Not often")
        answers.append("Sometimes")
        answers.append("Most of the time")
        step.multiple_choice?.answers.append(contentsOf: answers)
        HADS.steps.append(step)
        
        step = Step(title: "I get sudden feelings of panic", type: "multiple_choice")
        answers = [String]()
        answers.append("Very often indeed")
        answers.append("Quite often")
        answers.append("Not very often")
        answers.append("Not at all")
        step.multiple_choice?.answers.append(contentsOf: answers)
        HADS.steps.append(step)
        
        step = Step(title: "I can sit at ease and feel relaxed", type: "multiple_choice")
        answers = [String]()
        answers.append("Definitely")
        answers.append("Usually")
        answers.append("Not often")
        answers.append("Not at all")
        step.multiple_choice?.answers.append(contentsOf: answers)
        HADS.steps.append(step)
        
        step = Step(title: "I can enjoy a good book or radio or TV program", type: "multiple_choice")
        answers = [String]()
        answers.append("Often")
        answers.append("Sometimes")
        answers.append("Not often")
        answers.append("Very seldom")
        step.multiple_choice?.answers.append(contentsOf: answers)
        HADS.steps.append(step)
        
        surveys.append(HADS)
        
        /* Impact of Events Scale Revised (IES-R) */
        
        var IESR = Survey(title: "IESR")
        
        step = Step(title: "Any reminder brought back feelings about it", type: "multiple_choice")
        answers = [String]()
        answers.append("Not at all")
        answers.append("A little bit")
        answers.append("Moderately")
        answers.append("Quite a bit")
        answers.append("Extremely")
        step.multiple_choice?.answers.append(contentsOf: answers)
        IESR.steps.append(step)
        
        step = Step(title: "I had trouble staying asleep", type: "multiple_choice")
        answers = [String]()
        answers.append("Not at all")
        answers.append("A little bit")
        answers.append("Moderately")
        answers.append("Quite a bit")
        answers.append("Extremely")
        step.multiple_choice?.answers.append(contentsOf: answers)
        IESR.steps.append(step)
        
        step = Step(title: "Other things kept making me think about it", type: "multiple_choice")
        answers = [String]()
        answers.append("Not at all")
        answers.append("A little bit")
        answers.append("Moderately")
        answers.append("Quite a bit")
        answers.append("Extremely")
        step.multiple_choice?.answers.append(contentsOf: answers)
        IESR.steps.append(step)
        
        step = Step(title: "I felt irritable and angry", type: "multiple_choice")
        answers = [String]()
        answers.append("Not at all")
        answers.append("A little bit")
        answers.append("Moderately")
        answers.append("Quite a bit")
        answers.append("Extremely")
        step.multiple_choice?.answers.append(contentsOf: answers)
        IESR.steps.append(step)
        
        step = Step(title: "I avoided letting myself get upset when I thought about it or was reminded of it", type: "multiple_choice")
        answers = [String]()
        answers.append("Not at all")
        answers.append("A little bit")
        answers.append("Moderately")
        answers.append("Quite a bit")
        answers.append("Extremely")
        step.multiple_choice?.answers.append(contentsOf: answers)
        IESR.steps.append(step)
        
        step = Step(title: "I thought about it when I didn’t mean to", type: "multiple_choice")
        answers = [String]()
        answers.append("Not at all")
        answers.append("A little bit")
        answers.append("Moderately")
        answers.append("Quite a bit")
        answers.append("Extremely")
        step.multiple_choice?.answers.append(contentsOf: answers)
        IESR.steps.append(step)
        
        step = Step(title: "I felt as if it hadn’t happened or wasn’t real", type: "multiple_choice")
        answers = [String]()
        answers.append("Not at all")
        answers.append("A little bit")
        answers.append("Moderately")
        answers.append("Quite a bit")
        answers.append("Extremely")
        step.multiple_choice?.answers.append(contentsOf: answers)
        IESR.steps.append(step)
        
        step = Step(title: "I stayed away from reminders about it", type: "multiple_choice")
        answers = [String]()
        answers.append("Not at all")
        answers.append("A little bit")
        answers.append("Moderately")
        answers.append("Quite a bit")
        answers.append("Extremely")
        step.multiple_choice?.answers.append(contentsOf: answers)
        IESR.steps.append(step)
        
        step = Step(title: "Pictures about it popped into my mind", type: "multiple_choice")
        answers = [String]()
        answers.append("Not at all")
        answers.append("A little bit")
        answers.append("Moderately")
        answers.append("Quite a bit")
        answers.append("Extremely")
        step.multiple_choice?.answers.append(contentsOf: answers)
        IESR.steps.append(step)
        
        step = Step(title: "I was jumpy and easily startled", type: "multiple_choice")
        answers = [String]()
        answers.append("Not at all")
        answers.append("A little bit")
        answers.append("Moderately")
        answers.append("Quite a bit")
        answers.append("Extremely")
        step.multiple_choice?.answers.append(contentsOf: answers)
        IESR.steps.append(step)
        
        step = Step(title: "I tried not to think about it", type: "multiple_choice")
        answers = [String]()
        answers.append("Not at all")
        answers.append("A little bit")
        answers.append("Moderately")
        answers.append("Quite a bit")
        answers.append("Extremely")
        step.multiple_choice?.answers.append(contentsOf: answers)
        IESR.steps.append(step)
        
        step = Step(title: "I was aware that I still had a lot of feelings about it, but I didn’t deal with them", type: "multiple_choice")
        answers = [String]()
        answers.append("Not at all")
        answers.append("A little bit")
        answers.append("Moderately")
        answers.append("Quite a bit")
        answers.append("Extremely")
        step.multiple_choice?.answers.append(contentsOf: answers)
        IESR.steps.append(step)
        
        step = Step(title: "My feelings about it were kind of numb", type: "multiple_choice")
        answers = [String]()
        answers.append("Not at all")
        answers.append("A little bit")
        answers.append("Moderately")
        answers.append("Quite a bit")
        answers.append("Extremely")
        step.multiple_choice?.answers.append(contentsOf: answers)
        IESR.steps.append(step)
        
        step = Step(title: "I found myself acting or feeling as though I was back at that time", type: "multiple_choice")
        answers = [String]()
        answers.append("Not at all")
        answers.append("A little bit")
        answers.append("Moderately")
        answers.append("Quite a bit")
        answers.append("Extremely")
        step.multiple_choice?.answers.append(contentsOf: answers)
        IESR.steps.append(step)
        
        step = Step(title: "I had trouble falling asleep", type: "multiple_choice")
        answers = [String]()
        answers.append("Not at all")
        answers.append("A little bit")
        answers.append("Moderately")
        answers.append("Quite a bit")
        answers.append("Extremely")
        step.multiple_choice?.answers.append(contentsOf: answers)
        IESR.steps.append(step)
        
        step = Step(title: "I had waves of strong feelings about it", type: "multiple_choice")
        answers = [String]()
        answers.append("Not at all")
        answers.append("A little bit")
        answers.append("Moderately")
        answers.append("Quite a bit")
        answers.append("Extremely")
        step.multiple_choice?.answers.append(contentsOf: answers)
        IESR.steps.append(step)
        
        step = Step(title: "I tried to remove it from my memory", type: "multiple_choice")
        answers = [String]()
        answers.append("Not at all")
        answers.append("A little bit")
        answers.append("Moderately")
        answers.append("Quite a bit")
        answers.append("Extremely")
        step.multiple_choice?.answers.append(contentsOf: answers)
        IESR.steps.append(step)
        
        step = Step(title: "I had trouble concentrating", type: "multiple_choice")
        answers = [String]()
        answers.append("Not at all")
        answers.append("A little bit")
        answers.append("Moderately")
        answers.append("Quite a bit")
        answers.append("Extremely")
        step.multiple_choice?.answers.append(contentsOf: answers)
        IESR.steps.append(step)
        
        step = Step(title: "Reminders of it caused me to have physical reactions, such as sweating, trouble breathing, nausea, or a pounding heart", type: "multiple_choice")
        answers = [String]()
        answers.append("Not at all")
        answers.append("A little bit")
        answers.append("Moderately")
        answers.append("Quite a bit")
        answers.append("Extremely")
        step.multiple_choice?.answers.append(contentsOf: answers)
        IESR.steps.append(step)
        
        step = Step(title: "I had dreams about it", type: "multiple_choice")
        answers = [String]()
        answers.append("Not at all")
        answers.append("A little bit")
        answers.append("Moderately")
        answers.append("Quite a bit")
        answers.append("Extremely")
        step.multiple_choice?.answers.append(contentsOf: answers)
        IESR.steps.append(step)
        
        step = Step(title: "I felt watchful or on-guard", type: "multiple_choice")
        answers = [String]()
        answers.append("Not at all")
        answers.append("A little bit")
        answers.append("Moderately")
        answers.append("Quite a bit")
        answers.append("Extremely")
        step.multiple_choice?.answers.append(contentsOf: answers)
        IESR.steps.append(step)
        
        step = Step(title: "I tried not to talk about it", type: "multiple_choice")
        answers = [String]()
        answers.append("Not at all")
        answers.append("A little bit")
        answers.append("Moderately")
        answers.append("Quite a bit")
        answers.append("Extremely")
        step.multiple_choice?.answers.append(contentsOf: answers)
        IESR.steps.append(step)
        
        surveys.append(IESR)
        
        /* FMC */
        
        var FMC = Survey(title: "FMC")
        
        step = Step(title: "Preamble", type: "instruction")
        step.instruction?.content = "These questions are for a 6-month follow-up to see how you are going after your heart surgery. Some of the questions are the same questions you were asked before your heart surgery.\n\nFor each of the following questions, please select the reply that best describes your answer, or follow the instructions to answer the questions."
        FMC.steps.append(step)
        
        // Q2
        step = Step(title: "Have you attended an outpatients appointment since your discharge?", type: "multiple_choice")
        answers = [String]()
        answers.append("Yes")
        answers.append("No")
        step.multiple_choice?.answers.append(contentsOf: answers)
        FMC.steps.append(step)
        
        // Q2 pt. 2
        step = Step(title: "If yes, when did you attend the outpatients appointment?", type: "date")
        step.isSkippable = true
        FMC.steps.append(step)
        
        // Q3
        step = Step(title: "Have you been admitted to hospital since being discharged?", type: "multiple_choice")
        answers = [String]()
        answers.append("Yes")
        answers.append("No")
        step.multiple_choice?.answers.append(contentsOf: answers)
        FMC.steps.append(step)
        
        // Q3 pt. 2
        step = Step(title: "If yes, when did you get admitted, which hospital, and what for?", type: "text_field")
        step.subtitle = "If yes, please write the date, hospital name, reason for admission below."
        step.isSkippable = true
        FMC.steps.append(step)
        
        
        // Q4
        step = Step(title: "Have you been to the GP since being discharged?", type: "multiple_choice")
        answers = [String]()
        answers.append("Yes")
        answers.append("No")
        step.multiple_choice?.answers.append(contentsOf: answers)
        FMC.steps.append(step)
        
        // Q5
        step = Step(title: "Have you attended or are going to attend a cardiac rehabilitation program?", type: "multiple_choice")
        answers = [String]()
        answers.append("Yes")
        answers.append("No")
        step.multiple_choice?.answers.append(contentsOf: answers)
        FMC.steps.append(step)
        
        // Q5 pt. 2
        step = Step(title: "If yes, where?", type: "text_field")
        step.subtitle = "If yes, please write the hospital name."
        step.isSkippable = true
        FMC.steps.append(step)
        
        // Q7
        step = Step(title: "Have you experienced breathlessness since your operation?", type: "multiple_choice")
        answers = [String]()
        answers.append("Yes")
        answers.append("No")
        step.multiple_choice?.answers.append(contentsOf: answers)
        FMC.steps.append(step)
        
        //Q7 pt. 2
        step = Step(title: "If yes, after how much walking activity?", type: "multiple_choice")
        step.isSkippable = true
        answers = [String]()
        answers.append("I do not have any limitations on my physical activity. Ordinary physical activity does not cause me undue tiredness, racing heart, or shortness of breath")
        answers.append("I am slightly limited in my physical activity. I am comfortable at rest, but ordinary physical activity results in tiredness, racing heart, or shortness of breath")
        answers.append("I have marked limitation on my physical activity. I am comfortable at rest, but less than ordinary activity causes me tiredness, racing heart, or shortness of breath")
        answers.append("I am unable to carry out any physical activity without discomfort. I suffer symptoms when at rest. If any physical activity is undertaken, discomfort increases")
        step.multiple_choice?.answers.append(contentsOf: answers)
        FMC.steps.append(step)
        
        // Q8
        step = Step(title: "Have you experienced chest pain since your operation?", type: "multiple_choice")
        answers = [String]()
        answers.append("Yes")
        answers.append("No")
        step.multiple_choice?.answers.append(contentsOf: answers)
        FMC.steps.append(step)
        
        // Q8 pt. 2
        step = Step(title: "If yes, how much activity is required to bring on the chest pain?", type: "multiple_choice")
        step.isSkippable = true
        answers = [String]()
        answers.append("I only experience chest pain during strenuous or prolonged physical activity")
        answers.append("I experience a slight limitation in my daily activities, with chest pain occurring only during vigorous physical activity")
        answers.append("I experience moderate limitation. I experience chest pain when performing everyday living activities")
        answers.append("I am unable to perform any activity without chest pain")
        step.multiple_choice?.answers.append(contentsOf: answers)
        FMC.steps.append(step)
        
        // Quality of Life Questionnaire
        step = Step(title: "Quality of Life Questionnaire", type: "instruction")
        step.instruction?.content = "The next set of questions as for your views about your health."
        WHODAS.steps.append(step)
        
        // Q9
        step = Step(title: "In general, would you say your health is:", type: "multiple_choice")
        answers = [String]()
        answers.append("Excellent")
        answers.append("Very Good")
        answers.append("Good")
        answers.append("Fair")
        answers.append("Poor")
        step.multiple_choice?.answers.append(contentsOf: answers)
        FMC.steps.append(step)
        
        // Q10
        step = Step(title: "Does your health limit you in moderate activities? If so, how much?", type: "multiple_choice")
        step.subtitle = "e.g. moving a table, pushing a vacuum cleaner, bowling, or playing golf"
        answers = [String]()
        answers.append("Yes, limited a lot")
        answers.append("Yes, limited a little")
        answers.append("No, not limited at all")
        step.multiple_choice?.answers.append(contentsOf: answers)
        FMC.steps.append(step)
        
        step = Step(title: "Does your health limit you in climbing several flights of stairs? If so, how much?", type: "multiple_choice")
        answers = [String]()
        answers.append("Yes, limited a lot")
        answers.append("Yes, limited a little")
        answers.append("No, not limited at all")
        step.multiple_choice?.answers.append(contentsOf: answers)
        FMC.steps.append(step)
        
        // Q11
        step = Step(title: "During the past 4 weeks, how much of the time have you accomplished less than you would like as a result of your physical health?", type: "multiple_choice")
        answers = [String]()
        answers.append("All of the time")
        answers.append("Most of the time")
        answers.append("Some of the time")
        answers.append("A little of the time")
        answers.append("None of the time")
        step.multiple_choice?.answers.append(contentsOf: answers)
        FMC.steps.append(step)
        
        step = Step(title: "During the past 4 weeks, how much of the time were you limited in the kind of work or other activities you could do as a result of your physical health?", type: "multiple_choice")
        answers = [String]()
        answers.append("All of the time")
        answers.append("Most of the time")
        answers.append("Some of the time")
        answers.append("A little of the time")
        answers.append("None of the time")
        step.multiple_choice?.answers.append(contentsOf: answers)
        FMC.steps.append(step)
        
        // Q12
        step = Step(title: "During the past 4 weeks, how much of the time have you accomplished less than you would like as a result of any emotional problems (such as feeling depressed or anxious)?", type: "multiple_choice")
        answers = [String]()
        answers.append("All of the time")
        answers.append("Most of the time")
        answers.append("Some of the time")
        answers.append("A little of the time")
        answers.append("None of the time")
        step.multiple_choice?.answers.append(contentsOf: answers)
        FMC.steps.append(step)
        
        step = Step(title: "During the past 4 weeks, how much of the time did you work or do other activities less carefully than usual as a result of any emotional problems (such as feeling depressed or anxious)?", type: "multiple_choice")
        answers = [String]()
        answers.append("All of the time")
        answers.append("Most of the time")
        answers.append("Some of the time")
        answers.append("A little of the time")
        answers.append("None of the time")
        step.multiple_choice?.answers.append(contentsOf: answers)
        FMC.steps.append(step)
        
        // Q13
        step = Step(title: "During the past 4 weeks, how much did pain interfere with your normal work (including both work outside the home and housework)?", type: "multiple_choice")
        answers = [String]()
        answers.append("Not at all")
        answers.append("A little bit")
        answers.append("Moderately")
        answers.append("Quite a bit")
        answers.append("Extremely")
        step.multiple_choice?.answers.append(contentsOf: answers)
        FMC.steps.append(step)
        
        // Q14
        step = Step(title: "During the past 4 weeks, how much of the time have you felt calm and peaceful?", type: "multiple_choice")
        answers = [String]()
        answers.append("All of the time")
        answers.append("Most of the time")
        answers.append("Some of the time")
        answers.append("A little bit of the time")
        answers.append("None of the time")
        step.multiple_choice?.answers.append(contentsOf: answers)
        FMC.steps.append(step)
        
        step = Step(title: "During the past 4 weeks, how much of the time did you have a lot of energy?", type: "multiple_choice")
        answers = [String]()
        answers.append("All of the time")
        answers.append("Most of the time")
        answers.append("Some of the time")
        answers.append("A little bit of the time")
        answers.append("None of the time")
        step.multiple_choice?.answers.append(contentsOf: answers)
        FMC.steps.append(step)
        
        step = Step(title: "During the past 4 weeks, how much of the time have you felt downhearted or depressed?", type: "multiple_choice")
        answers = [String]()
        answers.append("All of the time")
        answers.append("Most of the time")
        answers.append("Some of the time")
        answers.append("A little bit of the time")
        answers.append("None of the time")
        step.multiple_choice?.answers.append(contentsOf: answers)
        FMC.steps.append(step)
        
        // Q15
        step = Step(title: "During the past 4 weeks, how much of the time has your physical health or emotional problems interfered with your social activities (like visiting with friends, relatives, etc.)?", type: "multiple_choice")
        answers = [String]()
        answers.append("All of the time")
        answers.append("Most of the time")
        answers.append("Some of the time")
        answers.append("A little bit of the time")
        answers.append("None of the time")
        step.multiple_choice?.answers.append(contentsOf: answers)
        FMC.steps.append(step)
        
        // Patient Health Questionnaire
        step = Step(title: "Patient Health Questionnaire", type: "instruction")
        step.instruction?.content = "The next set of questions is an important part of providing you with the best health care possible."
        WHODAS.steps.append(step)
        
        // Q16
        step = Step(title: "Over the past 2 weeks, have you had little interest or pleasure in doing things?", type: "multiple_choice")
        answers = [String]()
        answers.append("Not at all")
        answers.append("Several days")
        answers.append("More than half the days")
        answers.append("Nearly every day")
        step.multiple_choice?.answers.append(contentsOf: answers)
        FMC.steps.append(step)
        
        // Q17
        step = Step(title: "Over the past 2 weeks, have you been feeling down, depressed, or hopeless?", type: "multiple_choice")
        answers = [String]()
        answers.append("Not at all")
        answers.append("Several days")
        answers.append("More than half the days")
        answers.append("Nearly every day")
        step.multiple_choice?.answers.append(contentsOf: answers)
        FMC.steps.append(step)
        
        // Q18
        step = Step(title: "Over the past 2 weeks, have you had trouble falling or staying asleep, or sleeping to much?", type: "multiple_choice")
        answers = [String]()
        answers.append("Not at all")
        answers.append("Several days")
        answers.append("More than half the days")
        answers.append("Nearly every day")
        step.multiple_choice?.answers.append(contentsOf: answers)
        FMC.steps.append(step)
        
        // Q19
        step = Step(title: "Over the past 2 weeks, have you been feeling tired or having little energy?", type: "multiple_choice")
        answers = [String]()
        answers.append("Not at all")
        answers.append("Several days")
        answers.append("More than half the days")
        answers.append("Nearly every day")
        step.multiple_choice?.answers.append(contentsOf: answers)
        FMC.steps.append(step)
        
        // Q20
        step = Step(title: "Over the past 2 weeks, have you had poor appetite or been overeating?", type: "multiple_choice")
        answers = [String]()
        answers.append("Not at all")
        answers.append("Several days")
        answers.append("More than half the days")
        answers.append("Nearly every day")
        step.multiple_choice?.answers.append(contentsOf: answers)
        FMC.steps.append(step)
        
        // Q21
        step = Step(title: "Over the past 2 weeks, have you been feeling bad about yourself – or that you are a failure or have let yourself or your family down?", type: "multiple_choice")
        answers = [String]()
        answers.append("Not at all")
        answers.append("Several days")
        answers.append("More than half the days")
        answers.append("Nearly every day")
        step.multiple_choice?.answers.append(contentsOf: answers)
        FMC.steps.append(step)
        
        // Q22
        step = Step(title: "Over the past 2 weeks, have you had trouble concentrating on things, such as reading the newspaper or watching television?", type: "multiple_choice")
        answers = [String]()
        answers.append("Not at all")
        answers.append("Several days")
        answers.append("More than half the days")
        answers.append("Nearly every day")
        step.multiple_choice?.answers.append(contentsOf: answers)
        FMC.steps.append(step)
        
        // Q23
        step = Step(title: "Over the past 2 weeks, have you been moving or speaking so slowly that other people could have noticed. Or the opposite – being so fidgety or restless that you have been moving around a lot more than usual?", type: "multiple_choice")
        answers = [String]()
        answers.append("Not at all")
        answers.append("Several days")
        answers.append("More than half the days")
        answers.append("Nearly every day")
        step.multiple_choice?.answers.append(contentsOf: answers)
        FMC.steps.append(step)
        
        // Q24
        step = Step(title: "Over the past 2 weeks, have you had thoughts that you would be better off dead, or of hurting yourself in some way?", type: "multiple_choice")
        answers = [String]()
        answers.append("Not at all")
        answers.append("Several days")
        answers.append("More than half the days")
        answers.append("Nearly every day")
        step.multiple_choice?.answers.append(contentsOf: answers)
        FMC.steps.append(step)
        
        // Q25
        step = Step(title: "Over the past 2 weeks, how difficult have these problems made it for you to do your work, take care of things at home, or get along with other people?", type: "multiple_choice")
        answers = [String]()
        answers.append("Not difficult at all")
        answers.append("Somewhat difficult")
        answers.append("Very difficult")
        answers.append("Extremely difficult")
        step.multiple_choice?.answers.append(contentsOf: answers)
        FMC.steps.append(step)
        
        surveys.append(FMC)
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
    
    @objc func handleBeginButton() {
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
            instructionController.answers = [SurveyData]()
            
            beginButton.isEnabled = false
            beginButton.alpha = 0.5;
            
            let newNavigationController = UINavigationController(rootViewController: instructionController)
            present(newNavigationController, animated: true, completion: nil)
        } else if (survey.steps[currentStep].type == "multiple_choice") {
            let multipleChoiceController = MultipleChoiceController()
            multipleChoiceController.survey = survey
            multipleChoiceController.currentStep = currentStep
            multipleChoiceController.answers = [SurveyData]()
            
            beginButton.isEnabled = false
            beginButton.alpha = 0.5
            
            let newNavigationController = UINavigationController(rootViewController: multipleChoiceController)
            present(newNavigationController, animated: true, completion: nil)
        } else if (survey.steps[currentStep].type == "text_field" || survey.steps[currentStep].type == "numeric" || survey.steps[currentStep].type == "date") {
            let textFieldController = TextFieldController()
            textFieldController.survey = survey
            textFieldController.currentStep = currentStep
            textFieldController.answers = [SurveyData]()
            
            beginButton.isEnabled = false
            beginButton.alpha = 0.5
            
            let newNavigationController = UINavigationController(rootViewController: textFieldController)
            present(newNavigationController, animated: true, completion: nil)
        } else if (survey.steps[currentStep].type == "scale") {
            let scaleController = ScaleController()
            scaleController.survey = survey
            scaleController.currentStep = currentStep
            scaleController.answers = [SurveyData]()
            
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
