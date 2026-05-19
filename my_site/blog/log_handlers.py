import os
import logging
from datetime import datetime
from django.conf import settings

class DailyErrorFileHandler(logging.Handler):
    """
    Custom Python logging handler that monitors errors in the project.
    Whenever an ERROR or CRITICAL event occurs, it automatically creates/updates
    a text file named after the current date (YYYY-MM-DD.txt) inside the logs folder.
    """
    def emit(self, record):
        try:
            # Only monitor errors (ERROR and CRITICAL levels)
            if record.levelno >= logging.ERROR:
                # Format the log record into a readable string
                msg = self.format(record)
                
                # Get the current date in YYYY-MM-DD format
                date_str = datetime.now().strftime("%Y-%m-%d")
                filename = f"{date_str}.txt"
                
                # Define path: my_site/logs/
                logs_dir = os.path.join(settings.BASE_DIR, "logs")
                os.makedirs(logs_dir, exist_ok=True)
                
                filepath = os.path.join(logs_dir, filename)
                
                # Append the error details with timestamp to the file
                with open(filepath, "a", encoding="utf-8") as f:
                    f.write(f"======================================================================\n")
                    f.write(f"TIME: {datetime.now().strftime('%H:%M:%S')}\n")
                    f.write(f"LEVEL: {record.levelname}\n")
                    f.write(f"MODULE: {record.module}\n")
                    f.write(f"MESSAGE: {msg}\n")
                    f.write(f"======================================================================\n\n")
        except Exception:
            self.handleError(record)
