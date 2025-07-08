import std/[times, options, tables]
import naitsalib

type
    Task = ref object of RootObj
        id: int
        name*: string
        description*: string
        creationDate: DateTime
        startDate: Option[DateTime] # mutable optional datetime
        completionDate: Option[DateTime]
        lastModifiedDate: DateTime

    TaskManager* = ref object of RootObj
        tasks: OrderedTable[int, Task]
        nextId: int

proc newTaskManager*(): TaskManager =
    TaskManager(
        tasks: initOrderedTable[int, Task](),
        nextId: 1
    )

proc view(task: Task) =
    print(
        "ID:......... " & $task.id,
        "Task:....... " & task.name,
        "Description: " & task.description,
        "Created:.... " & $task.creationDate.format("yyyy-MM-dd HH:mm:ss"),
    )
    if task.startDate.isSome:
        print("Started:.... " & $task.startDate.get().format("yyyy-MM-dd HH:mm:ss"))
    else: 
        print("Started:.... Not started")

    if task.completionDate.isSome:
        print("Completed:.. " & $task.completionDate.get().format("yyyy-MM-dd HH:mm:ss"))
    else:
        print("Completed:.. Not completed")

method add*(tm: var TaskManager, name: string, description: string) {.base.} =
    let task: Task = Task(
        id: tm.nextId,
        name: name,
        description: description,
        creationDate: now(),
        startDate: none(DateTime),
        completionDate: none(DateTime)
        lastModifiedDate: now()
    )
    tm.tasks[tm.nextId] = task
    tm.nextId += 1 # increment ids

method viewAll*(tm: TaskManager) {.base.} =
    for id, task in tm.tasks.pairs:
        task.view()
        echo "\n"

method viewTask*(tm: TaskManager, id: int) {.base.} =
    if id in tm.tasks:
        tm.tasks[id].view()

method getTask*(tm: TaskManager, id: int): Option[Task] {.base.} =
    if id in tm.tasks:
        return some(tm.tasks[id])
    else:
        return none(Task)

method modName*(tm: TaskManager, id: int, name: string): bool {.base.} =
    if id in tm.tasks:
        tm.tasks[id].name = name
        tm.tasks[id].lastModifiedDate = now()
        return true
    return false

method modDescription*(tm: TaskManager, id: int, description: string): bool {.base.} =
    if id in tm.tasks:
        tm.tasks[id].description = description
        tm.tasks[id].lastModifiedDate = now()
        return true
    return false

method startTask*(tm: TaskManager, id: int): bool {.base.} =
    if id in tm.tasks:
        tm.tasks[id].startDate = some(now())
        tm.tasks[id].lastModifiedDate = now()
        return true
    return false

method completeTask*(tm: TaskManager, id: int): bool {.base.} =
    if id in tm.tasks:
        tm.tasks[id].completionDate = some(now())
        tm.tasks[id].lastModifiedDate = now()
        return true
    return false

method removeTask*(tm: TaskManager, id: int): bool {.base.} =
    if id in tm.tasks:
        tm.tasks.del(id)
        return true
    return false

method saveTasks*(tm: TaskManager, path: string) {.base.} = 
    # TODO
    discard

method loadTasks*(tm: var TaskManager, path: string) {.base.} = 
    # TODO
    discard
