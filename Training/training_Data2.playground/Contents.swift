import Cocoa
import CreateML

let trainingData = try MLDataTable(contentsOf: URL(fileURLWithPath: "/Users/shm/iOS_SentimentClassifierApp/Data/Data2/trainingData(2).csv"))
let testingData = try MLDataTable(contentsOf: URL(fileURLWithPath: "/Users/shm/iOS_SentimentClassifierApp/Data/Data2/testData(2).csv"))
//랜덤하게 testingData 생성할 때
//let(trainingData, testingData) = data.randomSplit(by: 0.8, seed: 5)

let sentimentClassifier = try MLTextClassifier(trainingData: trainingData, textColumn: "text", labelColumn: "label")

// Training accuracy as a percentage
let trainingAccuracy = (1.0 - sentimentClassifier.trainingMetrics.classificationError) * 100
// Validation accuracy as a percentage
let validationAccuracy = (1.0 - sentimentClassifier.validationMetrics.classificationError) * 100

print("trainingAccuracy : \(trainingAccuracy)\n")
print("validationAccuracy: \(validationAccuracy)\n")

// Evalution
let evaluationMetrics = sentimentClassifier.evaluation(on: testingData, textColumn: "text", labelColumn: "label")
let evalutionAccuracy = (1.0 - evaluationMetrics.classificationError ) * 100

let metadata = MLModelMetadata(author: "hyomin",
                               shortDescription: "A model trained to classify sentiment on tweets",
                               version: "1.0")

try sentimentClassifier.write(to: URL(fileURLWithPath: "//Users/shm/iOS_SentimentClassifierApp/Training/SentimentClassifier(2).mlmodel"),
                              metadata: metadata)

try sentimentClassifier.prediction(from: "수능 보기 싫다ㅜㅜ")
try sentimentClassifier.prediction(from: "사랑해~")
try sentimentClassifier.prediction(from: "강아지 너무 귀엽다😍")
try sentimentClassifier.prediction(from: "사야할 것 : 마우스, 키보드")

