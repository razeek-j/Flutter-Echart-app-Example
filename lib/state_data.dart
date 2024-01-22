class State{
  String? state;

  State(this.state);

  State.fromJson(Map<String, dynamic> json){
    state = json['state_province'];
  }
}