import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

//let queue: DispatchQueue = .init(label: "my_queue", attributes: .concurrent)
////let queue: DispatchQueue = .main
//
//
//var array = ["1", "2", "3"]
//queue.async { array[0] = "Hello1"; print("1") }
//queue.async { print(array) }
//queue.async { array[0] = "Hello1"; print("1") }
//queue.async { print(array) }
//queue.async { array[0] = "Hello1"; print("1") }
//queue.async { print(array) }
//queue.async { array[0] = "Hello2"; print("2") }
//
//queue.async { array[0] = "Hello2"; print("2") }
//queue.async { print(array) }
//queue.async { array[0] = "Hello2"; print("2") }
//
//queue.async { array[0] = "!"; print("3") }
//queue.async { print(array) }
//queue.async { array[0] = "!"; print("3") }
//
//queue.async { array[0] = "!"; print("3") }
//queue.async { print(array) }
//queue.async { array[0] = "World"; print("4") }
//
//queue.async { array[0] = "World"; print("4") }
//queue.async { print(array) }
//queue.async { array[0] = "World"; print("4") }

let groupItemsQueue = DispatchQueue(
    label: "group.items", attributes: .concurrent
)
let dispatchGroup = DispatchGroup()

let loadImagesItem = DispatchWorkItem {
    dispatchGroup.enter()
    sleep(1)
    print("Loaded images")
    dispatchGroup.leave()
}
let loadVideosItem = DispatchWorkItem {
    dispatchGroup.enter()
    sleep(2)
    print("Loaded videos")
    dispatchGroup.leave()
}

loadVideosItem.cancel()

groupItemsQueue.async(execute: loadImagesItem)
groupItemsQueue.async(execute: loadVideosItem)

dispatchGroup.notify(queue: groupItemsQueue) {
    print("Ended loading media")
}
