export class User {
  id: number;
  username: string;
  email: string;
  password: string;
  enabled: boolean;
  role: string;
  joinDate: string | null;
  updateDate: string | null;
  avatarUrl: string | null;
  battletag: string | null;

  constructor(
    id: number = 0,
    username: string = '',
    email: string = '',
    password: string = '',
    enabled: boolean = false,
    role: string = '',
    joinDate: string = '',
    updateDate: string = '',
    avatarUrl: string = '',
    battletag: string = ''
  ) {
    this.id = id;
    this.username = username;
    this.email = email;
    this.password = password;
    this.enabled = enabled;
    this.role = role;
    this.joinDate = joinDate;
    this.updateDate = updateDate;
    this.avatarUrl = avatarUrl;
    this.battletag = battletag;
  }
}
