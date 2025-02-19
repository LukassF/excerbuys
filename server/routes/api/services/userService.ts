import { ErrorWithCode } from "../../../exceptions/errorWithCode";
import {
  fetchUserById,
  updatePointsScore,
  updatePointsScoreWithUpdateTimestamp,
} from "../../../models/userModel";
import { IUserNoPassword } from "../../../shared/types";

export const getUserById = async (user_id: number) => {
  const foundUser = await fetchUserById(user_id);

  if (foundUser.rowCount && foundUser.rowCount > 0)
    return foundUser.rows[0] as IUserNoPassword;
  else {
    throw new ErrorWithCode(`No user found with id ${user_id}`, 404);
  }
};

export const updateUserPointsScore = async (
  user_id: number,
  points: number
) => {
  const response = await updatePointsScore(user_id, points);
  return response.command;
};

export const updateUserPointsScoreWithUpdateTimestamp = async (
  user_id: number,
  points: number,
  steps_updated_at: string
) => {
  const response = await updatePointsScoreWithUpdateTimestamp(
    user_id,
    points,
    steps_updated_at
  );
  return response.command;
};
