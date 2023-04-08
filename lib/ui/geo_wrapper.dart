part of flutter_bloc_geo;

class GeoWrapper extends StatelessWidget {
  final Widget Function(BuildContext, GeoStateError)? onErrorBuilder;
  final Widget Function(BuildContext, GeoStateLoading)? onLoadingBuilder;
  final Widget Function(BuildContext, GeoStateInitial)? onInitialBuilder;
  final Widget Function(BuildContext, GeoStateUpdate)? onUpdated;
  GeoWrapper(
      {this.onErrorBuilder,
      this.onLoadingBuilder,
      this.onInitialBuilder,
      this.onUpdated});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GeoBloc, GeoState>(builder: (context, state) {
      print("State : ${state.toString()}");
      if (state is GeoStateError) {
        if (this.onErrorBuilder != null) return onErrorBuilder!(context, state);

        return Text(
          'Something went wrong! ',
          style: TextStyle(color: Colors.red),
        );
      }
      if (state is GeoStateInitial) {
        if (this.onInitialBuilder != null)
          return onInitialBuilder!(context, state);

        return Center(child: Text('Initial State'));
      }
      if (state is GeoStateLoading) {
        if (this.onLoadingBuilder != null)
          return onLoadingBuilder!(context, state);
        return Center(child: CircularProgressIndicator());
      }

      if (state is GeoStateUpdate) {
        if (this.onUpdated != null) return onUpdated!(context, state);
        return GeoDisplayWidget(update: state.position);
      }
      return Container();
    });
  }
}
