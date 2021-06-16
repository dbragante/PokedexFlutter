import 'package:flutter/material.dart';
import '../widgets/infinite_grid_view.dart';
import 'detail_page.dart';
import '../widgets/pokemon_card.dart';
import '../controllers/home_controller.dart';
import '../core/app_const.dart';
import '../repositories/poke_repository_impl.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = HomeController(PokeRepositoryImpl());

  @override
  void initState() {
    _initialize();
    super.initState();
  }

  Future<void> _initialize() async {
    await _controller.fetch();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: InfiniteGridView(
        crossAxisCount: 2,
        itemBuilder: _buildPokemonCard,
        itemCount: _controller.length,
        hasNext: _controller.length < 1118,
        nextData: _onNextData,
      ),
    );
  }


class _ExamplePageState extends State<ExamplePage> {
  // controls the text label we use as a search bar
  final TextEditingController _filter = new TextEditingController();
  final dio = new Dio(); // for http requests
  String _searchText = "";
  List names = new List(); // names we get from API
  List filteredNames = new List(); // names filtered by search text
  Icon _searchIcon = new Icon(Icons.search); 
  Widget _appBarTitle = new Text( 'Search Example' );
}

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(
        'Pokedex',
        style: TextStyle(
            color: Colors.blue,
            fontFamily: 'Pokemon',
            backgroundColor: Colors.white,
            fontSize: 30),
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.black),
    );
  }

  void _onNextData() async {
    await _controller.next();
    setState(() {});
  }

  Widget _buildPokemonCard(BuildContext context, int index) {
    final pokemon = _controller.pokemons[index];
    return PokemonCard(
      pokemon: pokemon,
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => DetailPage(
              pokemon: pokemon,
            ),
          ),
        );
      },
    );
  }
}
