import sys
import argparse
from todoist.api import TodoistAPI

def parse_args(argv):
    parser = argparse.ArgumentParser()
    parser.add_argument("script_name")
    parser.add_argument("name", nargs='+')
    parser.add_argument("-o", "--project",
                        help="Existing project to add the task to")
    parser.add_argument("-p", "--priority",
                        help="Priority level to give the task from 1 to 4",
                        type=int,
                        choices=[1,2,3,4],
                        default=4)
    return parser.parse_args(argv)

if __name__ == "__main__":
    # Sync the api
    api = TodoistAPI('6d41a50f8f4a70b82a88831cbde7ab859762e7fc')
    api.sync()

    # Parse the command line arguments
    args = parse_args(sys.argv)

    # Get the project
    project = None
    for proj in api.state["projects"]:
        if args.project == proj["name"]:
            project = proj
            break

    assert(project)

    # Convert the priority to the inverted version used by the api
    priority = 5 - args.priority

    # Create the tasks
    for name in args.name:
        if name != sys.argv[0]:
            api.items.add(name, project['id'], priority=priority)

    # Commit the change
    api.commit()
