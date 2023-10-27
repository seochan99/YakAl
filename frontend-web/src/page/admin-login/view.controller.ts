import React, { useCallback, useState } from "react";

function useAdminLoginViewController() {
  /* State */
  const [snackbarOpen, setSnackbarOpen] = useState<boolean>(false);
  const [username, setUsername] = useState<string>("");
  const [password, setPassword] = useState<string>("");

  /* Logic */
  const loginButtonDisabled = username === "" || password === "";

  /* Callback */
  const onChangeUsername = useCallback(
    (event: React.ChangeEvent<HTMLInputElement>) => {
      setUsername(event.target.value);
    },
    [setUsername],
  );

  const onChangePassword = useCallback(
    (event: React.ChangeEvent<HTMLInputElement>) => {
      setPassword(event.target.value);
    },
    [setPassword],
  );

  const onClickLogin = useCallback(() => {
    setSnackbarOpen(true);
  }, [setSnackbarOpen]);

  return {
    username,
    onChangeUsername,
    password,
    onChangePassword,
    onClickLogin,
    loginButtonDisabled,
    snackbarOpen,
    setSnackbarOpen,
  };
}

export default useAdminLoginViewController;
