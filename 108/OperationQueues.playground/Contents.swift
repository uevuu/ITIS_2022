import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

let operationQueue = OperationQueue()
let blockOperation = BlockOperation {
    sleep(1)
    print("Hello world")
}
let anotherOperation = BlockOperation {
    sleep(1)
    print("Hello world 2")
}

blockOperation.addDependency(anotherOperation)

operationQueue.maxConcurrentOperationCount = 2
operationQueue.addOperation(blockOperation)
operationQueue.addOperation(anotherOperation)

operationQueue.addBarrierBlock {
    print("Barrier block")
}
operationQueue.waitUntilAllOperationsAreFinished()
