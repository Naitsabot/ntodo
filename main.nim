import todo

var taskManager = newTaskManager()

taskManager.add("Ring til Karoline", "Sig at hun er det pureste marmor")
taskManager.add("Buy groceries", "Milk, bread, eggs")

echo "View a task, with ID 1:"
taskManager.viewTask(1)
echo ""

echo "All tasks:"
taskManager.viewAll()


echo "Starting task with ID 1:"
if taskManager.startTask(1):
    echo "Task started successfully"
else:
    echo "Task not found"

echo "Completing task with ID 2:"
if taskManager.completeTask(2):
    echo "Task completed successfully"
else:
    echo "Task not found"

echo "\nAll tasks after modifications:"
taskManager.viewAll()

echo "Removing task with ID 1:"
if taskManager.removeTask(1):
    echo "Task removed successfully"
else:
    echo "Task not found"

echo "\nRemaining tasks:"
taskManager.viewAll()