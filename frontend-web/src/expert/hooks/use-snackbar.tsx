import React, { useCallback, useState } from "react";
import { Button, IconButton } from "@mui/material";

import CloseIcon from "@mui/icons-material/Close";

const useSnackbar = () => {
  const [open, setOpen] = useState<boolean>(false);

  const openSnackbar = useCallback(() => {
    setOpen(true);
  }, [setOpen]);

  const onClose = useCallback(
    (event: React.SyntheticEvent | Event, reason?: string) => {
      if (reason === "clickaway") {
        return;
      }

      setOpen(false);
    },
    [setOpen],
  );

  const actionComponent = (
    <React.Fragment>
      <Button color="secondary" size="small" onClick={onClose}>
        UNDO
      </Button>
      <IconButton size="small" aria-label="close" color="inherit" onClick={onClose}>
        <CloseIcon fontSize="small" />
      </IconButton>
    </React.Fragment>
  );

  return { open, onClose, actionComponent, openSnackbar };
};

export default useSnackbar;
