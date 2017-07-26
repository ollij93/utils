import sys
import argparse
from todoist.api import TodoistAPI

def parse_args(argv):
    parser = argparse.ArgumentParser()
    parser.add_argument("script_name")
    parser.add_argument("name")
    return parser.parse_args(argv)

if __name__ == "__main__":
    # Sync the api
    api = TodoistAPI('6d41a50f8f4a70b82a88831cbde7ab859762e7fc')
    api.sync()

    # Parse the command line arguments
    args = parse_args(sys.argv)

    # Create the project
    api.projects.add(args.name)

    # Commit the change
    api.commit()
